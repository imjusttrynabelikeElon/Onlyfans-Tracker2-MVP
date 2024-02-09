//
//  AddLinksViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/31/24.
//

import Foundation




import UIKit



class AddLinksViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ModelsNavSelectorDelegate, QuestionViewControllerDelegate {
    func didSelectOption(_ option: String) {
        
    }
    
    func didEnterManagerName(_ managerName: String) {
        print("Managers Name \(managerName)")
        ManagerName = managerName
        
    }
    
    func didUpdateManagerData(_ manager: Manager) {
        if let index = modelData.firstIndex(where: { $0.name == manager.name }) {
                    modelData[index] = manager
                }
    }
    
    
    var managerImageView: UIImageView!
      var addImageButton: UIButton!
    // Add managerName property
       var managerName: String?
    var modelData: [Manager] = []  // Ensure Model struct is defined
    var ManagerName: String?
   

    let instagramTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Manager Instagram Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let gmailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Manager Email Address"
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
        textField.placeholder = "Manager Twitter Username (Optional)"
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
        title = "Add Manager's Socials/Contact Info"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
          view.addGestureRecognizer(tap)
          NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
    
    @objc func taped(){
      self.view.endEditing(true)
    }

    @objc func KeyboardWillShow(sender: NSNotification){

        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardSize.height
        }

    }

    @objc func KeyboardWillHide(sender : NSNotification){

        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardSize.height
        }

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func populateModelData() {
     
        // Add other managers as needed

        // Populate the modelData array
       
    }

    private func saveDataForCurrentManager() {
          // Create a manager instance for the current manager
        var currentManagerData = Manager(name: ManagerName ?? "",
                                            phoneNumber: phoneNumberTextField.text ?? "",
                                            email: gmailTextField.text ?? "",
                                            imageData: managerImageView.image?.pngData())  // Pass image data

           // Add other properties to the manager instance as needed
           currentManagerData.instagram = instagramTextField.text
           currentManagerData.twitter = twitterTextField.text

        
           // Update UserDataSingleton with manager-related information
           UserDataSingleton.shared.managerName = currentManagerData.name
           UserDataSingleton.shared.managerPhoneNumber = currentManagerData.phoneNumber
           UserDataSingleton.shared.managerEmail = currentManagerData.email
           UserDataSingleton.shared.managerInstagram = currentManagerData.instagram
           UserDataSingleton.shared.managerTwitter = currentManagerData.twitter
           UserDataSingleton.shared.managerImage = currentManagerData.getImage()  //
        
          // Update the modelData array with the current manager's data
          if let index = modelData.firstIndex(where: { $0.name == currentManagerData.name }) {
              // If the manager is already in the modelData, update the data
              modelData[index] = currentManagerData
          } else {
              // If the manager is not in the modelData, append the data
              modelData.append(currentManagerData)
          }

          // Print the data for the current manager
          print("Manager Data:")
          print("Name: \(currentManagerData.name)")
          print("Phone Number: \(currentManagerData.phoneNumber)")
          print("Email: \(currentManagerData.email)")
          print("Instagram: \(currentManagerData.instagram ?? "N/A")")
          print("Twitter: \(currentManagerData.twitter ?? "N/A")")

          // Print the image data if needed
        if let imageData = currentManagerData.imageData, let modelImage = UIImage(data: imageData) {
              print("Image Data: \(imageData)")
          } else {
              print("No Image Data")
          }

          // Reset text fields and remove the image for the next manager
   //       resetTextFields()
          managerImageView.image = nil // Remove the image

          // Disable Next button until text fields are filled again
          nextButton.isEnabled = false
      }

    
    
    @objc private func nextButtonTapped() {
        // Ensure the necessary conditions are met before navigating
        let managerName = ManagerName
        let managerImage = managerImageView.image

        // Save data for the current manager
        saveDataForCurrentManager()
        print(saveDataForCurrentManager())

        // Create an instance of ModelsNavSelectorViewController
        let modelsNavSelectorVC = ModelsNavSelectorViewController()

        // Pass data to the next view controller
        modelsNavSelectorVC.managerName = managerName
        modelsNavSelectorVC.managerImage = managerImage
        modelsNavSelectorVC.modelData = modelData  // Pass the model data

        UserDataSingleton.shared.managerImage = managerImage
        UserDataSingleton.shared.managerName = ManagerName
        UserDataSingleton.shared.modelData = modelData
        
        // Set the delegate to self (AddLinksViewController) to receive updated manager data

        // Use the same navigation controller to push the ModelsNavSelectorViewController
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
        return true
    }
}
