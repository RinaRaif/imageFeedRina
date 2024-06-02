//
//  File.swift
//  ImageFeed
//
//  Created by Рина Райф on 01.06.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlackIOS
        
        initImages(view: view)
        initButton()
    }
    
    private func initImages(view: UIView) {
        if let logoImage = UIImage(named: "auth_screen_logo") {
            let authLogoImage = UIImageView(image: logoImage)
            
            authLogoImage.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(authLogoImage)
            
            NSLayoutConstraint.activate([
                authLogoImage.heightAnchor.constraint(equalToConstant: 60),
                authLogoImage.widthAnchor.constraint(equalToConstant: 60),
                authLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                authLogoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
    
    private func initButton() {
        let loginButton = UIButton()
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(.ypBlackIOS, for: .normal)
        loginButton.backgroundColor = .ypWhiteIOS
        loginButton.layer.cornerRadius = 16
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
                loginButton.heightAnchor.constraint(equalToConstant: 48),
                loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
            ])
        }

    
    @objc
    func loginButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ShowWebView", sender: nil)
        }
    }

