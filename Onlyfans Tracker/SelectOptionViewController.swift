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

    private func setupButtons() {
        let messageModelButton = createButton(withTitle: "Message Model", action: #selector(messageModelTapped))
        let callModelButton = createButton(withTitle: "Call Model", action: #selector(callModelTapped))
        let modelDataButton = createButton(withTitle: "Model Data", action: #selector(modelDataTapped))
        let remindersButton = createButton(withTitle: "Reminders", action: #selector(remindersTapped))

        // StackView for vertical alignment
        let verticalStackView1 = UIStackView(arrangedSubviews: [messageModelButton, callModelButton])
        verticalStackView1.axis = .vertical
        verticalStackView1.distribution = .fillEqually
        verticalStackView1.spacing = 20.0

        let verticalStackView2 = UIStackView(arrangedSubviews: [modelDataButton, remindersButton])
        verticalStackView2.axis = .vertical
        verticalStackView2.distribution = .fillEqually
        verticalStackView2.spacing = 20.0

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
            horizontalStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
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

    @objc private func messageModelTapped() {
        print("Message Model button tapped!")
        let phoneNumber = "sms://2123468423"
        if let url = URL(string: phoneNumber) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc private func callModelTapped() {
        print("Call Model button tapped!")
        let phoneNumber = "tel://2123468423"
        if let url = URL(string: phoneNumber) {
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
