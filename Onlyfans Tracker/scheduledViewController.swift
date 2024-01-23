//
//  scheduledViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//

import UIKit

import UIKit

struct Reminder {
    var title: String
    var notes: String
    var date: Date
}

protocol ReminderViewDelegate: AnyObject {
    func setReminder(title: String, notes: String, date: Date)
}

class ScheduledViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ReminderViewDelegate {

    private var reminders: [Reminder] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reminderCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Scheduled Reminders"
       print( reminders.count)
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)
        let reminder = reminders[indexPath.row]
        cell.textLabel?.text = "\(reminder.title) - \(formattedDateString(from: reminder.date))"
        return cell
    }

    // MARK: - Utility Functions

    private func formattedDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        return dateFormatter.string(from: date)
    }

    // Function to add a new reminder
    func addReminder(title: String, notes: String, date: Date) {
        let newReminder = Reminder(title: title, notes: notes, date: date)
        reminders.append(newReminder)
        tableView.reloadData()
    }

    // Function to delete a reminder at a specific index
    func deleteReminder(at index: Int) {
        reminders.remove(at: index)
        tableView.reloadData()
    }

    // Handle setting the reminder using the selected date, title, and notes
    func setReminder(title: String, notes: String, date: Date) {
        print("Set reminder for: \(date), Title: \(title), Notes: \(notes)")
        addReminder(title: title, notes: notes, date: date)
    }
    @objc private func createReminderButtonTapped() {
        let reminderViewController = ReminderViewController()
        reminderViewController.delegate = self // Set the delegate
        navigationController?.pushViewController(reminderViewController, animated: true)
    }

    

    // Function to update an existing reminder at a specific index
    func updateReminder(at index: Int, title: String, notes: String, date: Date) {
        reminders[index] = Reminder(title: title, notes: notes, date: date)
        tableView.reloadData()
    }
}
