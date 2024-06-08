//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Рина Райф on 23.05.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Private Methods
    
    private func initProfileImage (view: UIView) {
        view.backgroundColor = .ypBackgroundIOS
        let profileImage = UIImage(named: "Photo")
        let profilePhotoView = UIImageView(image: profileImage)
        
        profilePhotoView.tag = 1
        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profilePhotoView)
        
        profilePhotoView.layer.cornerRadius = 35
        profilePhotoView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            profilePhotoView.heightAnchor.constraint(equalToConstant: 70),
            profilePhotoView.widthAnchor.constraint(equalToConstant: 70),
            profilePhotoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            profilePhotoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    private func initLogoutButton(view: UIView) {
        let logOutButton = UIButton.systemButton(
            with: UIImage(named: "ExitAccount_Button")!,
            target: self,
            action: #selector(Self.didTapLogoutButton)
        )
        
        logOutButton.tintColor = .ypRedIOS
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logOutButton)
        
        NSLayoutConstraint.activate([
            logOutButton.centerYAnchor.constraint(equalTo: view.viewWithTag(1)!.centerYAnchor),
            logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
    }
    
    private func initLabels(view: UIView) {
        let userName = UILabel()
        userName.text = "Екатерина Новикова"
        userName.textColor = .ypWhiteIOS
        userName.font = .systemFont(ofSize: 23)
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userName)
        
        let userNickName = UILabel()
        userNickName.text = "@ekaterina_nov"
        userNickName.textColor = .ypGrayIOS
        userNickName.font = .systemFont(ofSize: 13)
        
        userNickName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNickName)
        
        let userDescription = UILabel()
        userDescription.text = "Hello, world"
        userDescription.textColor = .ypWhiteIOS
        userDescription.font = .systemFont(ofSize: 13)
        
        userDescription.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userDescription)
        
        let stackView = UIStackView(arrangedSubviews: [userName, userNickName, userDescription])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.viewWithTag(1)!.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProfileImage (view: view)
        initLogoutButton(view: view)
        initLabels(view: view)
    }
    
    @objc
    private func didTapLogoutButton() {
        for view in view.subviews {
            if view is UILabel {
                view.removeFromSuperview()
            } else {
                if let imageView = view as? UIImageView {
                    imageView.image = UIImage(named: "tab_profile_no_active")
                    imageView.tintColor = .ypGrayIOS
                }
            }
        }
        
    }
}

