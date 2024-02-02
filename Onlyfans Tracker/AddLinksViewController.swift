//
//  AddLinksViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/31/24.
//

import Foundation




import UIKit



class AddLinksViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var managerImageView: UIImageView!
      var addImageButton: UIButton!
    // Add managerName property
       var managerName: String?

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
        
        managerImageView = UIImageView()
             managerImageView.backgroundColor = .lightGray
             managerImageView.contentMode = .scaleAspectFit
             managerImageView.layer.cornerRadius = 8.0
             managerImageView.layer.masksToBounds = true

             // Create add image button
             addImageButton = UIButton(type: .system)
             addImageButton.setTitle("Add Manager's Picture", for: .normal)
             addImageButton.addTarget(self, action: #selector(addImageTapped), for: .touchUpInside)

             // Set up constraints for managerImageView
             managerImageView.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(managerImageView)
        
        NSLayoutConstraint.activate([
                   managerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
                   managerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   managerImageView.widthAnchor.constraint(equalToConstant: 100.0), // Adjust the width as needed
                   managerImageView.heightAnchor.constraint(equalToConstant: 100.0)  // Adjust the height as needed
               ])

               // Set up constraints for addImageButton
               addImageButton.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(addImageButton)

               NSLayoutConstraint.activate([
                   addImageButton.topAnchor.constraint(equalTo: managerImageView.bottomAnchor, constant: 20.0),
                   addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   addImageButton.widthAnchor.constraint(equalToConstant: 200.0), // Adjust the width as needed
                   addImageButton.heightAnchor.constraint(equalToConstant: 40.0)   // Adjust the height as needed
               ])
        
      
        
       }
    
    
    
    @objc func nextButtonTapped() {
        // Ensure the necessary conditions are met before navigating
       
              let managerName = managerName
              let managerImage = managerImageView.image
       

        // Create an instance of ModelsNavSelectorViewController
        let modelsNavSelectorVC = ModelsNavSelectorViewController()

        // Pass data to the next view controller
        modelsNavSelectorVC.managerName = managerName
        modelsNavSelectorVC.managerImage = managerImage

        // Push the ModelsNavSelectorViewController onto the navigation stack
        navigationController?.pushViewController(modelsNavSelectorVC, animated: true)
    }


    @objc func addImageTapped() {
        // Implement the logic to open the image picker and set the selected image to managerImageView
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            managerImageView.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
            instagramTitleLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            instagramTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            instagramTextField.topAnchor.constraint(equalTo: instagramTitleLabel.bottomAnchor, constant: 10),
            instagramTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instagramTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instagramTextField.heightAnchor.constraint(equalToConstant: 40),

            gmailTitleLabel.topAnchor.constraint(equalTo: instagramTextField.bottomAnchor, constant: 20),
            gmailTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            gmailTextField.topAnchor.constraint(equalTo: gmailTitleLabel.bottomAnchor, constant: 10),
            gmailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gmailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gmailTextField.heightAnchor.constraint(equalToConstant: 40),

            phoneNumberTitleLabel.topAnchor.constraint(equalTo: gmailTextField.bottomAnchor, constant: 20),
            phoneNumberTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberTitleLabel.bottomAnchor, constant: 10),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),

            twitterTitleLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            twitterTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            twitterTextField.topAnchor.constraint(equalTo: twitterTitleLabel.bottomAnchor, constant: 10),
            twitterTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            twitterTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            twitterTextField.heightAnchor.constraint(equalToConstant: 40),

            nextButton.topAnchor.constraint(equalTo: twitterTextField.bottomAnchor, constant: 50),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 120),
        ])

       

        // Add target to handle text changes in text fields
        instagramTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        gmailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        twitterTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    @objc func textFieldDidChange() {
        // Enable the Next button if all required text fields are filled
        nextButton.isEnabled = !instagramTextField.text!.isEmpty &&
                                     isValidEmail(email: gmailTextField.text) &&
                                     !phoneNumberTextField.text!.isEmpty 
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
