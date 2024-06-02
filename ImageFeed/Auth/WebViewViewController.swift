//
//  WebViewViewController.swift.swift
//  ImageFeed
//
//  Created by Рина Райф on 01.06.2024.
//

import UIKit
import WebKit

fileprivate let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"

final class WebViewViewController: UIViewController { 
    var webView: WKWebView!
    
//    enum WebViewConstants {
//        static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем экземпляр WKWebView
        webView = WKWebView(frame: self.view.bounds)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        
        // Активируем ограничения для webView
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        loadAuthView()
        
    }
    
    private func loadAuthView() {
        guard var urlComponents = URLComponents(string: UnsplashAuthorizeURLString)
        else {
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: Constants.accessScope)
        ]
        
        guard let url = urlComponents.url else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
