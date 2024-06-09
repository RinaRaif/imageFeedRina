//
//  File.swift
//  ImageFeed
//
//  Created by Рина Райф on 01.06.2024.
//

import UIKit

//MARK: - AuthViewControllerDelegate
protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

//MARK: - AuthViewController
final class AuthViewController: UIViewController {
    
    //MARK: - Public Properties
    weak var delegate: AuthViewControllerDelegate?
    
    //MARK: - Private properties
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    
    //MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard let webViewViewController = segue.destination as? WebViewViewController else {
                fatalError("Failed for prepare \(ShowWebViewSegueIdentifier)")
            }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

//MARK: - WebViewViewControllerDelegate
extension AuthViewController: WebViewViewControllerDelegate {
    
    //MARK: - Public Methods
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.didAuthenticate(self, didAuthenticateWithCode: code)
    }
}



















////MARK: - AuthViewControllerDelegate
//protocol AuthViewControllerDelegate: AnyObject {
//    func didAuthenticate(_ vc: AuthViewController, didAuthenticateWithCode code: String)
//}
//
////MARK: - AuthViewController
//final class AuthViewController: UIViewController {
//
//    //MARK: - Public Properties
//    weak var delegate: AuthViewControllerDelegate?
//
//    //MARK: - Private properties
//    private var authImageView = UIImageView()
//    private var loginButton = UIButton()
//
//    //MARK: - Override Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .ypBlackIOS
//
//        initImages()
//        initLogButton()
//        configureBackButton()
//    }
//
//    // MARK: - Action
//    @objc
//    private func didTapLoginButton() {
//        segueToWebView()
//    }
//
//    @objc
//    private func didTapBackButton() {
//        dismiss(animated: true, completion: nil)
//    }
//
//    //MARK: - Private Methods
//    private func initImages() {
//        authImageView.image = UIImage(named: "auth_screen_logo")
//
//        authImageView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(authImageView)
//
//        NSLayoutConstraint.activate([
//            authImageView.heightAnchor.constraint(equalToConstant: 60),
//            authImageView.widthAnchor.constraint(equalToConstant: 60),
//            authImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            authImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//
//    private func initLogButton() {
//        loginButton.setTitle("Войти", for: .normal)
//        loginButton.setTitleColor(.ypBlackIOS, for: .normal)
//        loginButton.backgroundColor = .ypWhiteIOS
//        loginButton.layer.cornerRadius = 16
//        loginButton.layer.masksToBounds = true
//        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
//
//        loginButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(loginButton)
//
//        NSLayoutConstraint.activate([
//            loginButton.heightAnchor.constraint(equalToConstant: 48),
//            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
//        ])
//    }
//
//    func configureBackButton() {
//        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backward")
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
//                                                           style: .plain,
//                                                           target: self,
//                                                           action: #selector(didTapBackButton))
//        navigationItem.backBarButtonItem?.tintColor = UIColor.ypBlackIOS
//    }
//
//    private func segueToWebView() {
//        let webViewVC = WebViewViewController()
//        webViewVC.delegate = self
//        navigationController?.pushViewController(webViewVC, animated: true)
//    }
//}
//
////MARK: - WebViewViewControllerDelegate
//extension AuthViewController: WebViewViewControllerDelegate {
//
//    //MARK: - Public Methods
//    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
//        navigationController?.popViewController(animated: true)
//    }
//
//    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
//        delegate?.didAuthenticate(self, didAuthenticateWithCode: code)
//    }
//}
