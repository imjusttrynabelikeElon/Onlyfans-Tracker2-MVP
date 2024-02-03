//
//  SelectOptionViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//

import UIKit
import EventKit

class SelectOptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 1.0)
        title = "Pick Option"
        setupButtons()
    }
    
    var selectedModel: Model?
    var modelData: [Model]?

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
        let verticalStackView3 = UIStackView(arrangedSubviews: [instagramButton, twitterButton, onlyFansButton])
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


    @objc private func instagramTapped() {
        print("Model's Instagram button tapped!")
        if let instagramUsername = selectedModel?.instagram,
           let url = URL(string: "https://www.instagram.com/\(instagramUsername)/"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        print(selectedModel?.instagram)
    }

    @objc private func twitterTapped() {
        print("Model's Twitter button tapped!")
        if let twitterUsername = selectedModel?.twitter,
           let url = URL(string: "https://twitter.com/\(twitterUsername)/"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        print(selectedModel?.twitter)
    }

    @objc private func onlyFansTapped() {
        print("Model's OnlyFans button tapped!")
        if let onlyFansUsername = selectedModel?.onlyFansLink,
           let url = URL(string: "https://onlyfans.com/\(onlyFansUsername)/"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        print(selectedModel?.onlyFansLink)
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
