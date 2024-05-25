//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Рина Райф on 23.05.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    @IBOutlet private var avatarImageView: UIImage!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var userEmailLabel: UILabel!
    @IBOutlet private var DescriptionLabel: UILabel!
    
    @IBOutlet private var logoutButton: UIButton!
    
    @IBAction private func didTapLogoutButton() {
    }
}
