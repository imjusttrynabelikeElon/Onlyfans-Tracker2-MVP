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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 1.0)
        title = "Pick Option"
        setupButtons()
    }

    private func setupButtons() {
        let callManagerButton = createButton(withTitle: "Call Manager", action: #selector(callManagerTapped))
        let messageManagerButton = createButton(withTitle: "Message", action: #selector(messageManagerTapped))
        let managerDataButton = createButton(withTitle: "Manager Data", action: #selector(managerDataTapped))
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
        let verticalStackView3 = UIStackView(arrangedSubviews: [instagramButton, twitterButton])
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
        print("Call Manager button tapped!")
        // Replace "manager_phone_number" with the actual phone number of the manager
        let phoneNumber = "tel://manager_phone_number"
        if let url = URL(string: phoneNumber) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc private func messageManagerTapped() {
        print("Message Manager button tapped!")
        // Replace "manager_phone_number" with the actual phone number of the manager
        let phoneNumber = "sms://manager_phone_number"
        if let url = URL(string: phoneNumber) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc private func managerDataTapped() {
        print("Manager Data button tapped!")
      
    }

    @objc private func remindersTapped() {
        print("Reminders button tapped!")
        if let remindersURL = URL(string: "x-apple-reminderkit://"), UIApplication.shared.canOpenURL(remindersURL) {
            UIApplication.shared.open(remindersURL, options: [:], completionHandler: nil)
        }
    }

    @objc private func instagramTapped() {
        print("Manager's Instagram button tapped!")
        // Replace "manager_instagram_username" with the actual Instagram username of the manager
        let instagramURL = URL(string: "https://www.instagram.com/manager_instagram_username/")
        if let url = instagramURL, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc private func twitterTapped() {
        print("Manager's Twitter button tapped!")
        // Replace "manager_twitter_username" with the actual Twitter username of the manager
        let twitterURL = URL(string: "https://twitter.com/manager_twitter_username/")
        if let url = twitterURL, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
