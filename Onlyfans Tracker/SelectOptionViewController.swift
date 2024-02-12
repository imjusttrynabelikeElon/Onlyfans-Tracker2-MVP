//
//  SelectOptionViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//

import UIKit
import EventKit

class SelectOptionViewController: UIViewController {

    var userData: UserData? // Add this property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 1.0)
        title = "Pick Option"
      //  navigationItem.hidesBackButton = true
        
        // Retrieve user data from UserDataManager
        if let loadedUserData = UserDataManager.shared.userData {
            // Ensure userData is set before attempting to load the selected model
            userData = loadedUserData
            
            // Load the selected model
            self.loadSelectedModel { [weak self] in
                // This completion block will be called when the model is loaded
                print("OUHEWIUF \(self?.selectedModel)")

                // Perform actions that depend on the loaded model
                // For example, update the UI or navigate to the next screen
                self?.handleModelLoaded()
            }
        } else {
            print("Error: UserData is nil")
            // Handle the case where user data is nil (perhaps show an error message)
        }


     
        setupButtons()
        setupSignOutButton()
    }
    
    var selectedModel: Model? {
            didSet {
                // Save selected model to UserDefaults when it changes
                saveSelectedModel()
            }
        }
    var modelData: [Model]?
    
    private func handleModelLoaded() {
          // Example: Navigate to the next screen based on user role
          self.handleUserRoleAndNavigate()
      }
    private var verticalStackView3: UIStackView!

    private func setupButtons() {
        let messageModelButton = createButton(withTitle: "Message Model", action: #selector(messageModelTapped))
        let callModelButton = createButton(withTitle: "Call Model", action: #selector(callModelTapped))
        let modelDataButton = createButton(withTitle: "Model Data", action: #selector(modelDataTapped))
        let remindersButton = createButton(withTitle: "Reminders", action: #selector(remindersTapped))
        let instagramButton = createButton(withTitle: "Model's Instagram", action: #selector(instagramTapped))
        let twitterButton = createButton(withTitle: "Model's Twitter", action: #selector(twitterTapped))
        let onlyFansButton = createButton(withTitle: "Model's OF", action: #selector(onlyFansTapped))

        // StackView for vertical alignment
        let verticalStackView1 = UIStackView(arrangedSubviews: [messageModelButton, callModelButton])
        verticalStackView1.axis = .vertical
        verticalStackView1.distribution = .fillEqually
        verticalStackView1.spacing = 40.0

        let verticalStackView2 = UIStackView(arrangedSubviews: [modelDataButton, remindersButton])
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
        verticalStackView3 = UIStackView(arrangedSubviews: [instagramButton, twitterButton, onlyFansButton])
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
    
    // Modify the saveSelectedModel function
    private func saveSelectedModel() {
        guard let userData = userData else {
            print("userData is nil in saveSelectedModel")
            return
        }

        let key = "SelectedModelKey_\(userData.uid)"

        if let encodedData = try? JSONEncoder().encode(selectedModel) {
            UserDefaults.standard.set(encodedData, forKey: key)
            // Make sure to synchronize UserDefaults
            UserDefaults.standard.synchronize()
        }
    }
    
    private func handleUserRoleAndNavigate() {
           // Your logic to determine the next screen based on user role
           // Example:
           let selectOptionViewController = SelectOptionViewController()
           selectOptionViewController.userData = self.userData
        //   self.navigationController?.pushViewController(selectOptionViewController, animated: true)
       }
    private func loadSelectedModel(completion: @escaping () -> Void) {
        guard let userData = userData else {
            print("userData is nil in loadSelectedModel")
            completion()
            return
        }

        let key = "SelectedModelKey_\(userData.uid)"

        if let savedData = UserDefaults.standard.data(forKey: key),
           let loadedModel = try? JSONDecoder().decode(Model.self, from: savedData) {
           selectedModel = loadedModel
        }

        // Call the completion handler to signal that the model has been loaded
        completion()
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

        // Create a new instance of OnboardingViewController
        let LoginViewController = LoginViewController(userData: userData!)

        // Set the new view controllers as the only items in the navigation stack
        navigationController?.setViewControllers([LoginViewController], animated: true)

        print("Sign Out button tapped!")
    }

    @objc private func instagramTapped() {
        print("Model's Instagram button tapped!")

        if let instagramUsername = selectedModel?.instagram, !instagramUsername.isEmpty {
            // Save the Instagram username to userData
            userData?.socialInfo.instagram = instagramUsername

            if let url = URL(string: "https://www.instagram.com/\(instagramUsername)/"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                print(instagramUsername)
            }
          
        }
    }

    @objc private func twitterTapped() {
        print("Model's Twitter button tapped!")

        if let twitterUsername = selectedModel?.twitter, !twitterUsername.isEmpty {
            // Save the Twitter username to userData
            userData?.socialInfo.twitter = twitterUsername

            if let url = URL(string: "https://twitter.com/\(twitterUsername)/"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                print(twitterUsername)
            }
          
        }
    }

    @objc private func onlyFansTapped() {
        print("Model's OnlyFans button tapped!")

        if let onlyFansUsername = selectedModel?.onlyFansLink, !onlyFansUsername.isEmpty {
            // Save the OnlyFansLink to userData
            userData?.socialInfo.onlyFansLink = onlyFansUsername

            if let url = URL(string: "https://onlyfans.com/\(onlyFansUsername)/"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                print(onlyFansUsername)
            }
        }
    }


    private func retrieveSocialMediaInfo() {
        if let instagramUsername = UserDefaults.standard.string(forKey: "InstagramUsername_\(userData?.uid ?? "")") {
            print("Instagram Username retrieved: \(instagramUsername)")
        }

        if let twitterUsername = UserDefaults.standard.string(forKey: "TwitterUsername_\(userData?.uid ?? "")") {
            print("Twitter Username retrieved: \(twitterUsername)")
        }

        if let onlyFansUsername = UserDefaults.standard.string(forKey: "OnlyFansUsername_\(userData?.uid ?? "")") {
            print("OnlyFans Username retrieved: \(onlyFansUsername)")
        }
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

    @objc private func messageModelTapped() {
        print("Message Model button tapped!")
        if let phoneNumber = selectedModel?.phoneNumber, let url = URL(string: "sms://\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc private func callModelTapped() {
        print("Call Model button tapped!")
        if let phoneNumber = selectedModel?.phoneNumber, let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc private func modelDataTapped() {
        print("Model Data button tapped!")
        let modelDataViewController = DataViewController()
        navigationController?.pushViewController(modelDataViewController, animated: true)
    }

    @objc private func remindersTapped() {
        print("Reminders button tapped!")
        if let remindersURL = URL(string: "x-apple-reminderkit://"), UIApplication.shared.canOpenURL(remindersURL) {
            UIApplication.shared.open(remindersURL, options: [:], completionHandler: nil)
        }
    }
}

// fix the small bug where it would not push to the link because inside of the addLinksVC the user enters the name but leaves a space at the end. That makes the url not push for some reason.
