//
//  NavSelectorViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//

import UIKit
import SDWebImage

class NavSelectorViewController: UIViewController {
    var avatarButton: UIButton!
    var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Your Models"

        // Set background color
        view.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 1.0) // Adjust the color values

        // Customize navigation bar
        let darkPinkColor = UIColor(red: 219/255, green: 112/255, blue: 147/255, alpha: 1.0) // Dark pink color
        navigationController?.navigationBar.barTintColor = darkPinkColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]

        // Set the background color of the navigation bar title
        navigationController?.navigationBar.backgroundColor = darkPinkColor

        // Assuming you have an avatar URL
        let avatarURL = URL(string: "https://public.onlyfans.com/files/1/1t/1tf/1tf7bdqagp5v8xeqw5cbrxut4vsjbc6a1679622331/63758808/avatar.jpg")!

        // Create an avatar button
        avatarButton = UIButton()
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.clipsToBounds = true
        avatarButton.sd_setImage(with: avatarURL, for: .normal)
        avatarButton.layer.cornerRadius = avatarButton.frame.width / 2
        avatarButton.layer.borderWidth = 2.0
        avatarButton.layer.borderColor = UIColor.white.cgColor
        avatarButton.layer.shadowColor = UIColor.gray.cgColor
        avatarButton.layer.shadowOpacity = 0.5
        avatarButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        avatarButton.layer.shadowRadius = 4.0
        avatarButton.addTarget(self, action: #selector(avatarTapped), for: .touchUpInside)

        // Create info label
        infoLabel = UILabel()
        infoLabel.text = "Tap On Model To View Her Features"
        infoLabel.textColor = .black
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont.systemFont(ofSize: 23.0)
        infoLabel.numberOfLines = 0

        // Set up constraints for avatarButton
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarButton)

        NSLayoutConstraint.activate([
            avatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -83),
            avatarButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5), // Adjust the multiplier as needed
            avatarButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4) // Adjust the multiplier as needed
        ])

        // Set up constraints for infoLabel
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)

        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: avatarButton.bottomAnchor, constant: 20.0)
        ])
    }

    @objc func avatarTapped() {
        print("Avatar tapped!")

        // Add flick animation
        UIView.animate(withDuration: 0.1, animations: {
            self.avatarButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.avatarButton.transform = .identity
            }
        }

        // Create an instance of SelectOptionViewController
        let selectOptionViewController = SelectOptionViewController()

        // Push the SelectOptionViewController onto the navigation stack
        navigationController?.pushViewController(selectOptionViewController, animated: true)
    }
}
