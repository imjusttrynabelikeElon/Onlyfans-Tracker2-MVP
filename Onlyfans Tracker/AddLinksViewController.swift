//
//  AddLinksViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/31/24.
//

import Foundation




import UIKit



class AddLinksViewController: UIViewController, UITextFieldDelegate {
    let instagramTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Manager Instagram"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let gmailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Manager Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Manager Phone Number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad // Set keyboard type to number pad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let twitterTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Manager Twitter (Optional)"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false // Disable initially
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Add Manager's Links/Contact Info"

        // Set the delegate for phoneNumberTextField, gmailTextField, and twitterTextField
        phoneNumberTextField.delegate = self
        gmailTextField.delegate = self
        twitterTextField.delegate = self
    }

    func setupUI() {
        view.backgroundColor = .white

        let instagramTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Instagram"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let gmailTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Email"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let phoneNumberTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Phone Number"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let twitterTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Manager Twitter"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        view.addSubview(instagramTitleLabel)
        view.addSubview(instagramTextField)
        view.addSubview(gmailTitleLabel)
        view.addSubview(gmailTextField)
        view.addSubview(phoneNumberTitleLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(twitterTitleLabel)
        view.addSubview(twitterTextField)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            instagramTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            instagramTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            instagramTextField.topAnchor.constraint(equalTo: instagramTitleLabel.bottomAnchor, constant: 5),
            instagramTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instagramTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instagramTextField.heightAnchor.constraint(equalToConstant: 40),

            gmailTitleLabel.topAnchor.constraint(equalTo: instagramTextField.bottomAnchor, constant: 20),
            gmailTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            gmailTextField.topAnchor.constraint(equalTo: gmailTitleLabel.bottomAnchor, constant: 5),
            gmailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gmailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gmailTextField.heightAnchor.constraint(equalToConstant: 40),

            phoneNumberTitleLabel.topAnchor.constraint(equalTo: gmailTextField.bottomAnchor, constant: 20),
            phoneNumberTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberTitleLabel.bottomAnchor, constant: 5),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),

            twitterTitleLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            twitterTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            twitterTextField.topAnchor.constraint(equalTo: twitterTitleLabel.bottomAnchor, constant: 5),
            twitterTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            twitterTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            twitterTextField.heightAnchor.constraint(equalToConstant: 40),

            nextButton.topAnchor.constraint(equalTo: twitterTextField.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 120),
        ])

        // Add target to handle text changes in text fields
        instagramTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        gmailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        twitterTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange() {
        // Enable the Next button if all required text fields are filled
        nextButton.isEnabled = !instagramTextField.text!.isEmpty &&
                                     isValidEmail(email: gmailTextField.text) &&
                                     !phoneNumberTextField.text!.isEmpty &&
                                     isValidLink(link: twitterTextField.text)
    }

    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            // Allow only numeric characters
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }

    func isValidEmail(email: String?) -> Bool {
        // Check if the email ends with "@gmail.com"
        if let email = email, email.lowercased().hasSuffix("@gmail.com") {
            return true
        }
        return false
    }
    func isValidLink(link: String?) -> Bool {
         // Check if the link is in a valid format
         if let link = link, let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
             return true
         }
         return false
     }
}
