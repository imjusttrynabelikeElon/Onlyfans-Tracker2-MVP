//
//  AddModelLinksViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/31/24.
//

import UIKit
import Foundation

class AddModelLinksViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var currentModel: Int = 1 // The current model being added
    private var totalModels: Int // Total number of models to add
    
    
    // Array to store model data (links and phone numbers)
    private var modelData: [Model] = []

    
    let onlyFansLinkTextField: UITextField = {
          let textField = UITextField()
          textField.placeholder = "Model's OnlyFans Link"
          textField.borderStyle = .roundedRect
          textField.translatesAutoresizingMaskIntoConstraints = false
          return textField
      }()

    let instagramTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Model Instagram"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let gmailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Model Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Model Phone Number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad // Set keyboard type to number pad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let twitterTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Model Twitter (Optional)"
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
    
    let imagePickerButton: UIButton = {
          let button = UIButton(type: .system)
          button.setImage(UIImage(systemName: "photo"), for: .normal)
          button.tintColor = .systemBlue
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
      }()
    
    let modelImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.backgroundColor = .lightGray
         imageView.contentMode = .scaleAspectFit
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
    let imagePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap Blue Button To Place Picture of your model inside"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold) // Set the desired weight (e.g., .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()



    
    init(numberOfModels: Int) {
        self.totalModels = numberOfModels
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateTitle()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(instagramTextField)
        view.addSubview(gmailTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(twitterTextField)
        view.addSubview(nextButton)
        view.addSubview(onlyFansLinkTextField)
        view.addSubview(imagePickerButton)
        view.addSubview(modelImageView)
        view.addSubview(imagePlaceholderLabel)

        NSLayoutConstraint.activate([
            imagePlaceholderLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -220),
            imagePlaceholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            imagePickerButton.topAnchor.constraint(equalTo: imagePlaceholderLabel.bottomAnchor, constant: 10),

            imagePickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePickerButton.widthAnchor.constraint(equalToConstant: 30),
            imagePickerButton.heightAnchor.constraint(equalToConstant: 30),

            modelImageView.topAnchor.constraint(equalTo: imagePickerButton.bottomAnchor, constant: 20),
            modelImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modelImageView.widthAnchor.constraint(equalToConstant: 100),
            modelImageView.heightAnchor.constraint(equalToConstant: 100),

            onlyFansLinkTextField.topAnchor.constraint(equalTo: modelImageView.bottomAnchor, constant: 20),
            onlyFansLinkTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            onlyFansLinkTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            onlyFansLinkTextField.heightAnchor.constraint(equalToConstant: 40),

            instagramTextField.topAnchor.constraint(equalTo: onlyFansLinkTextField.bottomAnchor, constant: 20),
            instagramTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instagramTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instagramTextField.heightAnchor.constraint(equalToConstant: 40),

            gmailTextField.topAnchor.constraint(equalTo: instagramTextField.bottomAnchor, constant: 20),
            gmailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gmailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gmailTextField.heightAnchor.constraint(equalToConstant: 40),

            phoneNumberTextField.topAnchor.constraint(equalTo: gmailTextField.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),

            twitterTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            twitterTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            twitterTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            twitterTextField.heightAnchor.constraint(equalToConstant: 40),

            nextButton.topAnchor.constraint(equalTo: twitterTextField.bottomAnchor, constant: 50),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 120),
        ])


        // Add target to handle text changes in text fields
        
        onlyFansLinkTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        instagramTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        gmailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        twitterTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        // ... (existing target actions and nextButton setup)
            imagePickerButton.addTarget(self, action: #selector(imagePickerButtonTapped), for: .touchUpInside)

    }
    
    // Function to validate email format
      func isValidEmail(email: String?) -> Bool {
          guard let email = email else { return false }

          let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
          let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
          return emailPredicate.evaluate(with: email)
      }

     func isValidOnlyFansLink(link: String?) -> Bool {
          guard let link = link, let url = URL(string: link) else { return false }
          // Add any specific validation for OnlyFans link if needed
          return UIApplication.shared.canOpenURL(url)
      }
      // Function to validate link format
      func isValidLink(link: String?) -> Bool {
          guard let link = link, let url = URL(string: link) else { return false }
          return UIApplication.shared.canOpenURL(url)
      }
    
    @objc private func textFieldDidChange() {
          // Enable the Next button if all required text fields are filled
          nextButton.isEnabled = !instagramTextField.text!.isEmpty &&
              isValidEmail(email: gmailTextField.text) &&
              !phoneNumberTextField.text!.isEmpty &&
              (twitterTextField.text?.isEmpty ?? true || isValidLink(link: twitterTextField.text)) &&
              isValidLink(link: onlyFansLinkTextField.text)
      }
    
    
    @objc private func imagePickerButtonTapped() {
           // Present image picker
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.sourceType = .photoLibrary
           imagePicker.allowsEditing = false

           present(imagePicker, animated: true)
       }

    
  
    
    // Inside AddModelLinksViewController
    @objc private func nextButtonTapped() {
        // Save data for the current model and reset text fields
        saveDataForCurrentModel()
        resetTextFields()

        // Move to the next model
        currentModel += 1

        // Update the title based on the current model
        updateTitle()

        if currentModel > totalModels {
            // Print modelData for debugging
            print("Model Data:")
            for (index, model) in modelData.enumerated() {
                print("Model \(index + 1) - Image: \(model.image != nil ? "Set" : "Not Set")")
            }

            // Push to NavSelectorViewController and pass the modelData
            let navSelectorViewController = NavSelectorViewController(modelData: modelData)
            navigationController?.pushViewController(navSelectorViewController, animated: true)
        }
    }

    
    // Function to handle the "Finish" button tap
       @objc private func finishButtonTapped() {
           // Perform any additional actions if needed before pushing back
           // to OnboardingViewController

           // Push back to OnboardingViewController
           navigationController?.popToRootViewController(animated: true)
       }

    private func saveDataForCurrentModel() {
        // Create a model instance for the current model
        var currentModelData = Model(onlyFansLink: onlyFansLinkTextField.text)
        // Add other properties to the model instance as needed
        currentModelData.instagram = instagramTextField.text
        currentModelData.email = gmailTextField.text
        currentModelData.phoneNumber = phoneNumberTextField.text
        currentModelData.twitter = twitterTextField.text
        currentModelData.image = modelImageView.image // Save the image
        
        // Append the model instance to the modelData array
        modelData.append(currentModelData)
        
        // Print the data for the current model
        print("Model \(currentModel) Data:")
        print("OnlyFansLink: \(currentModelData.onlyFansLink ?? "N/A")")
        print("Instagram: \(currentModelData.instagram ?? "N/A")")
        print("Email: \(currentModelData.email ?? "N/A")")
        print("Phone Number: \(currentModelData.phoneNumber ?? "N/A")")
        print("Twitter: \(currentModelData.twitter ?? "N/A")")
        
        // Print the image data if needed
        if let imageData = currentModelData.image?.pngData() {
            print("Image Data: \(imageData)")
        } else {
            print("No Image Data")
        }
        
        // Reset text fields and remove the image for the next model
        resetTextFields()
        modelImageView.image = nil // Remove the image
        
        // Disable Next button until text fields are filled again
        nextButton.isEnabled = false
    }



    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
           picker.dismiss(animated: true, completion: nil)

           guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
               return
           }

           modelImageView.image = pickedImage
           imagePlaceholderLabel.isHidden = true
       }
     
    private func resetTextFields() {
        // Reset text fields for the next model
        instagramTextField.text = ""
        gmailTextField.text = ""
        phoneNumberTextField.text = ""
        twitterTextField.text = ""
        onlyFansLinkTextField.text = ""
        
        // Disable Next button until text fields are filled again
        nextButton.isEnabled = false
    }
    
    private func updateTitle() {
        // Update the title based on the current model
        title = "Add Model \(currentModel) Links/Contact Info"
    }
    
    // ... (isValidEmail and isValidLink functions)
    
    
}


