//
//  WebViewViewController.swift.swift
//  ImageFeed
//
//  Created by Рина Райф on 01.06.2024.
//

import UIKit
import WebKit

//MARK: - Protocol WebViewControllerDelegate
protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}

//MARK: - class WebViewViewController
final class WebViewViewController: UIViewController {
    
    //MARK: - Private Constants // +
    enum WebViewConstants {
        static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    }
    
    //MARK: - Public Properties
    weak var delegate: WebViewViewControllerDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var progressView: UIProgressView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAuthView()
        configureProgressiveView()
        updateProgress()
        configureBackButtonCustom()
        
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new, context: nil)
        updateProgress()
    }
    // Добавляем наблюдателя, чтобы отслеживать прогресс загрузки страницы
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self,
                               forKeyPath: #keyPath(WKWebView.estimatedProgress),
                               context: nil)
    }
    // Удаляем наблюдателя, чтобы избежать утечек памяти
    
    //MARK: - Override Methods
    override func observeValue(forKeyPath keyPath: String?,  //
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            updateProgress()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    // Вызывается, если изменяется значение наблюдаемого свойства. Если изменения были у estimatedProgress, то вызываем updateProgress
    
    
    //MARK: - Private Methods
    private func configureProgressiveView() {
        progressView.progressViewStyle = .default
        progressView.progressTintColor = .ypBlackIOS
        progressView.progress = 0.5
    }
    
    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
    // Обновлям прогресс в progressView в соответствии с прогрессом загрузки webView.
    
    private func loadAuthView() {
        guard var urlComponents = URLComponents(string: WebViewConstants.unsplashAuthorizeURLString) else {
            print("Authorization page is not found")
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: Constants.accessScope)
        ]
        
        guard let url = urlComponents.url else {
            print("Authorization page is not found")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
        
        updateProgress()
    }
    // Загружаем страницу авторизации
    
    private func configureBackButtonCustom() {
        navigationItem.hidesBackButton = true
        let backButtonCustom = UIBarButtonItem(image: UIImage(named: "nav_back_button"), style: .plain, target: self, action: #selector(didTapBackButtonCustom))
        navigationItem.leftBarButtonItem = backButtonCustom
    }
    
    @objc private func didTapBackButtonCustom() {
        delegate?.webViewViewControllerDidCancel(self)
    }
}

//MARK: - WKNavigationDelegate
extension WebViewViewController: WKNavigationDelegate {
    
    //MARK: - Methods
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    //MARK: - Private Methods
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == "/oauth/authorize/native",
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == "code" })
        {
            return codeItem.value
        } else {
            return nil
        }
    }
}
