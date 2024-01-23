//
//  ReminderViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//


import UIKit




class ReminderViewController: UIViewController {

    weak var delegate: ReminderViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title:"
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        return label
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Enter title"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes:"
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        return label
    }()

    private let notesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter notes"
        textField.borderStyle = .roundedRect
        textField.contentVerticalAlignment = .top // Align text to the top
        return textField
    }()


    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.minimumDate = Date()
        picker.backgroundColor = .white
        return picker
    }()

    private let setReminderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set Reminder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(setReminderButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(notesLabel)
        view.addSubview(notesTextField)
        view.addSubview(datePicker)
        view.addSubview(setReminderButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesTextField.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        setReminderButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),

            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),

            notesLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16.0),
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),

            notesTextField.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 8.0),
            notesTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            notesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            // Increase the height of the notesTextField
            notesTextField.heightAnchor.constraint(equalToConstant: 120.0),

            datePicker.topAnchor.constraint(equalTo: notesTextField.bottomAnchor, constant: 16.0),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),

            setReminderButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20.0),
            setReminderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setReminderButton.widthAnchor.constraint(equalToConstant: 150.0),
            setReminderButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    

    @objc private func setReminderButtonTapped() {
        let selectedDate = datePicker.date
        let title = titleTextField.text ?? ""
        let notes = notesTextField.text ?? ""
        print("Set reminder for: \(selectedDate), Title: \(title), Notes: \(notes)")

        // Notify the delegate (ScheduledViewController) about the new reminder
        delegate?.setReminder(title: title, notes: notes, date: selectedDate)

        // Optionally, you can pop to the ScheduledViewController after setting the reminder
        navigationController?.popToRootViewController(animated: true)
    }


}
