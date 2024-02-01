//
//  QuestionViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/31/24.
//


import UIKit

protocol QuestionViewControllerDelegate: AnyObject {
    func didSelectOption(_ option: String)
}

class QuestionViewController: UIViewController, UITextFieldDelegate, QuestionViewControllerDelegate {
    var question: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "OFM Role"
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white

        let label = UILabel()
        label.text = question
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        let managerButton = UIButton(type: .system)
        managerButton.setTitle("Model", for: .normal)
        managerButton.addTarget(self, action: #selector(managerButtonTapped), for: .touchUpInside)
        managerButton.translatesAutoresizingMaskIntoConstraints = false

        let modelButton = UIButton(type: .system)
        modelButton.setTitle("Manager", for: .normal)
        modelButton.addTarget(self, action: #selector(modelButtonTapped), for: .touchUpInside)
        modelButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        view.addSubview(managerButton)
        view.addSubview(modelButton)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),

            managerButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            managerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),

            modelButton.topAnchor.constraint(equalTo: managerButton.topAnchor),
            modelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90), // Adjust the constant as needed
        ])

    }

    @objc func managerButtonTapped() {
        // Present the appropriate view controller for the "What's your manager's name?" section
        let managersNameVC = ManagerNameViewController()
        managersNameVC.delegate = self
        navigationController?.pushViewController(managersNameVC, animated: true)
    }

    @objc func modelButtonTapped() {
        // Present the appropriate view controller for the "How many models do you have?" section
        let howManyModelsVC = HowManyModelsViewController()
        howManyModelsVC.delegate = self
        navigationController?.pushViewController(howManyModelsVC, animated: true)
    }

    // Implement QuestionViewControllerDelegate methods as needed

    // For example:
    func didSelectOption(_ option: String) {
        // Handle the selected option
        print("Selected option: \(option)")
    }
}
