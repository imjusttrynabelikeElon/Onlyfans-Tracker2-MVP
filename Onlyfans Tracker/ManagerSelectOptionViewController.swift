//
//  ManagerSelectOptionViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/2/24.
//

import Foundation
import UIKit

class ManagerSelectOptionViewController: UIViewController {
    var selectedManager: Manager?
    private var verticalStackView3: UIStackView!
    var userData: UserData?
    var managerData: ManagerStruct?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 1.0)
        title = "Pick Option"
        navigationItem.hidesBackButton = false
        
     
      
        setupButtons()
        setupSignOutButton()
    }

    private func setupButtons() {
        let callManagerButton = createButton(withTitle: "Call Manager", action: #selector(callManagerTapped))
        let messageManagerButton = createButton(withTitle: "Message", action: #selector(messageManagerTapped))
        let managerDataButton = createButton(withTitle: "Email Manager", action: #selector(emailManagerTapped))
        let remindersButton = createButton(withTitle: "Reminders", action: #selector(remindersTapped))
        let instagramButton = createButton(withTitle: "Manager's Instagram", action: #selector(instagramTapped))
        let twitterButton = createButton(withTitle: "Manager's Twitter", action: #selector(twitterTapped))

        // StackView for vertical alignment
        let verticalStackView1 = UIStackView(arrangedSubviews: [callManagerButton, messageManagerButton])
        verticalStackView1.axis = .vertical
        verticalStackView1.distribution = .fillEqually
        verticalStackView1.spacing = 40.0

        let verticalStackView2 = UIStackView(arrangedSubviews: [managerDataButton, remindersButton])
        verticalStackView2.axis = .vertical
        verticalStackView2.distribution = .fillEqually
        verticalStackView2.spacing = 40.0

        // StackView for horizontal alignment
        let horizontalStackView = UIStackView(arrangedSubviews: [verticalStackView1, verticalStackView2])
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 20.0

        view.addSubview(horizontalStackView)

        // Add constraints for stack view
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
        ])

        // StackView for vertical alignment below horizontalStackView
         verticalStackView3 = UIStackView(arrangedSubviews: [instagramButton, twitterButton])
        verticalStackView3.axis = .vertical
        verticalStackView3.distribution = .fillEqually
        verticalStackView3.spacing = 40.0

        view.addSubview(verticalStackView3)

        // Add constraints for verticalStackView3 below horizontalStackView
        verticalStackView3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView3.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            verticalStackView3.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor),
            verticalStackView3.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 80.0),
            verticalStackView3.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50.0)
        ])
    }

    private func setupSignOutButton() {
        let signOutButton = createButton(withTitle: "Sign Out", action: #selector(signOutTapped))
        signOutButton.setTitleColor(UIColor.white, for: .normal) // Set title color to blue

        view.addSubview(signOutButton)

        // Add constraints for signOutButton
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.topAnchor.constraint(equalTo: verticalStackView3.bottomAnchor, constant: 40.0)
        ])
    }

    
    @objc private func signOutTapped() {
        // Implement the sign-out functionality here
        // For example, you can clear user data, navigate to the login screen, etc.

        // Check if userData is not nil before creating LoginViewController
        guard let userData = UserDataManager.shared.userData else {
            print("userData is nil. Unable to sign out.")
            return
        }

        // Create a new instance of OnboardingViewController
        let loginVC = LoginViewController(userData: userData)

        // Set the new view controllers as the only items in the navigation stack
        navigationController?.setViewControllers([loginVC], animated: true)

        print("Sign Out button tapped!")
    }

    
    private func createButton(withTitle title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 219/255, green: 112/255, blue: 147/255, alpha: 1.0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22.0)
        button.layer.cornerRadius = 10.0
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    @objc private func callManagerTapped() {
        // Implement the logic to make a call using the manager's phone number
        if let phoneNumber = selectedManager?.phoneNumber, let phoneURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }

    @objc private func messageManagerTapped() {
        // Implement the logic to open the messaging app with the manager's phone number
        // Note: This will open the default messaging app; you might need to adjust it based on your requirements.
        if let phoneNumber = selectedManager?.phoneNumber, let messageURL = URL(string: "sms://\(selectedManager?.phoneNumber)"), UIApplication.shared.canOpenURL(messageURL) {
            UIApplication.shared.open(messageURL, options: [:], completionHandler: nil)
        }
    }

    @objc private func emailManagerTapped() {
        // Implement the logic to send an email using the manager's email
        
        // Unwrap the optional email
        if let email = selectedManager?.email, !email.isEmpty {
            let emailURLString = "mailto:\(email)"
            managerData?.email = selectedManager?.email
            
            // Create URL only if the string is not empty
            if let emailURL = URL(string: emailURLString), UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
            }
            
            // Save the manager's email to UserDefaults
            saveManagerEmailToUserDefaults(email)
        }
        print(selectedManager?.email)
        managerData?.email = selectedManager?.email
    }

    private func saveManagerEmailToUserDefaults(_ email: String) {
        // Assuming you have access to the user's UID
        guard let uid = userData?.uid else {
            print("Error: User UID is nil.")
            return
        }

        // Use a unique key for the manager's email
        let key = "ManagerEmail_\(uid)"

        // Save the email to UserDefaults
        UserDefaults.standard.set(email, forKey: key)
        // Make sure to synchronize UserDefaults
        UserDefaults.standard.synchronize()
    }


    @objc private func remindersTapped() {
        print("Reminders button tapped!")
        if let remindersURL = URL(string: "x-apple-reminderkit://"), UIApplication.shared.canOpenURL(remindersURL) {
            UIApplication.shared.open(remindersURL, options: [:], completionHandler: nil)
        }
    }

    @objc private func instagramTapped() {
        print("Manager's Instagram button tapped!")

        // Unwrap the optional string
        if let instagramUsername = selectedManager?.instagram, !instagramUsername.isEmpty {
            let instagramURLString = "https://www.instagram.com/\(instagramUsername)/"
            
            managerData?.instagram = instagramUsername
            print("\(managerData?.instagram) manager ig")
            // Create URL only if the string is not empty
            if let url = URL(string: instagramURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }

            managerData?.instagram = instagramUsername
            print("\(managerData?.instagram) manager ig")
            // Save the manager's Instagram username to UserDefaults
            saveManagerSocialMediaToUserDefaults(instagramUsername, socialMediaKey: "InstagramUsername")
        }
    }

    @objc private func twitterTapped() {
        print("Manager's Twitter button tapped!")

        // Unwrap the optional string
        if let twitterUsername = selectedManager?.twitter, !twitterUsername.isEmpty {
            let twitterURLString = "https://twitter.com/\(twitterUsername)"
            managerData?.twitter = twitterUsername
            // Create URL only if the string is not empty
            if let url = URL(string: twitterURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            managerData?.twitter = twitterUsername
            // Save the manager's Twitter username to UserDefaults
            saveManagerSocialMediaToUserDefaults(twitterUsername, socialMediaKey: "TwitterUsername")
        }
    }

    private func saveManagerSocialMediaToUserDefaults(_ username: String, socialMediaKey: String) {
        // Assuming you have access to the user's UID
        guard let uid = userData?.uid else {
            print("Error: User UID is nil.")
            return
        }

        // Use a unique key for the social media username
        let key = "\(socialMediaKey)_\(uid)"

        // Save the username to UserDefaults
        UserDefaults.standard.set(username, forKey: key)
        // Make sure to synchronize UserDefaults
        UserDefaults.standard.synchronize()
    }

}
