//
//  SelectOptionViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//

import UIKit

import UIKit
import EventKit

class SelectOptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Pick Option"
        setupButtons()
    }

    private func setupButtons() {
        let messageModelButton = createButton(withTitle: "Message Model")
        let callModelButton = createButton(withTitle: "Call Model")
        let modelDataButton = createButton(withTitle: "Model Data")
        let remindersButton = createButton(withTitle: "Reminders")

        // StackView for vertical alignment
        let verticalStackView1 = UIStackView(arrangedSubviews: [messageModelButton, callModelButton])
        verticalStackView1.axis = .vertical
        verticalStackView1.distribution = .fillEqually
        verticalStackView1.spacing = 420.0

        let verticalStackView2 = UIStackView(arrangedSubviews: [modelDataButton, remindersButton])
        verticalStackView2.axis = .vertical
        verticalStackView2.distribution = .fillEqually
        verticalStackView2.spacing = 420.0

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

        // Increase the height of the vertical stack views
        NSLayoutConstraint.activate([
            verticalStackView1.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, constant: -100),
            verticalStackView2.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, constant: -100)
        ])
    }

    private func createButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22.0)
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }

    @objc private func buttonTapped(sender: UIButton) {
        switch sender.title(for: .normal) {
        case "Message Model":
            // Handle Message Model button tap
            print("Message Model button tapped!")
            let phoneNumber = "sms://2123468423"
            if let url = URL(string: phoneNumber) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case "Call Model":
            // Handle Call Model button tap
            print("Call Model button tapped!")
            let phoneNumber = "tel://2123468423"
            if let url = URL(string: phoneNumber) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case "Model Data":
            // Handle Model Data button tap
            print("Model Data button tapped!")

            // Create an instance of DataViewController
            let dataViewController = DataViewController()

            // Push DataViewController onto the navigation stack
            navigationController?.pushViewController(dataViewController, animated: true)
        case "Reminders":
            // Handle Reminders button tap
            print("Reminders button tapped!")

            // Create an instance of ReminderViewViewController
            let reminderViewViewController = ReminderViewViewController()

            // Push ReminderViewViewController onto the navigation stack
            navigationController?.pushViewController(reminderViewViewController, animated: true)

        default:
            break
        }
    }


    private func createReminder() {
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .reminder) { (granted, error) in
            if granted && error == nil {
                let reminder = EKReminder(eventStore: eventStore)
                reminder.title = "Sample Reminder"
                reminder.calendar = eventStore.defaultCalendarForNewReminders()

                do {
                    try eventStore.save(reminder, commit: true)
                    print("Reminder created successfully.")
                } catch {
                    print("Error creating reminder: \(error.localizedDescription)")
                }
            } else {
                print("Access to reminders not granted.")
            }
        }
    }
}
