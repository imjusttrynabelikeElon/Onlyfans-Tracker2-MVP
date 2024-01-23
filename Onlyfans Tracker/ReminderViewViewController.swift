//
//  ReminderViewViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//

import UIKit

class ReminderViewViewController: UIViewController {

    var previousButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Reminders"
        setupButtons()
        setupCreateReminderButton()
    }

    private func setupButtons() {
        let buttonTitles = ["Scheduled", "Today", "All"]
        var previousButton: UIButton?

        for title in buttonTitles {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(sectionButtonTapped(_:)), for: .touchUpInside)
            view.addSubview(button)

            button.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                button.heightAnchor.constraint(equalToConstant: 40.0)
                // You can adjust the height and other constraints as needed
            ])

            if let previousButton = previousButton {
                // Set vertical spacing between buttons
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 8.0)
                ])
            } else {
                // Set top constraint for the first button
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0)
                ])
            }

            previousButton = button
        }
    }

    private func setupCreateReminderButton() {
        let createReminderButton = UIButton()
        createReminderButton.setTitle("Create Reminder", for: .normal)
        createReminderButton.setTitleColor(.black, for: .normal)
        createReminderButton.addTarget(self, action: #selector(createReminderButtonTapped), for: .touchUpInside)
        view.addSubview(createReminderButton)

        createReminderButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            createReminderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createReminderButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            createReminderButton.widthAnchor.constraint(equalToConstant: 200.0), // Adjust width as needed
            createReminderButton.heightAnchor.constraint(equalToConstant: 40.0),
        ])
    }


    @objc private func sectionButtonTapped(_ sender: UIButton) {
        let sectionTitle = sender.title(for: .normal) ?? ""

        switch sectionTitle {
        case "Scheduled":
            let scheduledViewController = ScheduledViewController()
            navigationController?.pushViewController(scheduledViewController, animated: true)
        case "Today":
            let todayViewController = todayViewController()
            navigationController?.pushViewController(todayViewController, animated: true)
        case "All":
            let allViewController = allViewController()
            navigationController?.pushViewController(allViewController, animated: true)
        default:
            break
        }
    }

    @objc private func createReminderButtonTapped() {
        let reminderViewController = ReminderViewController()
        navigationController?.pushViewController(reminderViewController, animated: true)
    }
}

// the the VCs for each view
