//
//  LoginViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/30/24.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol AuthenticationDelegate: AnyObject {
    func didSignIn(userData: UserData)
    func didFetchManagerData(managerData: [Manager])
    
}


class LoginViewController: UIViewController, AddModelLinksDelegate {
    func didAddModels(_ models: [Model], socialInfo: SocialInfo) {
        // Handle the added models or perform any necessary actions
               print("Models added:", models)

               // Access and update the userData's socialInfo
        self.userData.socialInfo = socialInfo
    }
    
    func didAddModels(_ models: [Model]) {
        // Check if userData is not nil
        if self.userData != nil {
            // If userData is not nil, update modelData
            self.userData.modelData = models
            // Update any other properties as needed
        }
    }

    
    
    var userData: UserData
    let emptyModelData: [Model] = []
    var managerData: Manager?
    let loadedManagerData = ManagerDataManager.shared.loadManagerData()
    
    weak var delegate: AuthenticationDelegate?
    
    let socialInfoDictionary: [String: String] = [
        "instagram": "example_instagram",
        "twitter": "example_twitter",
        "onlyFansLink": "example_onlyFansLink"
        // Add other key-value pairs as needed
    ]


    // Assuming you have an initializer for LoginViewController
     init(userData: UserData) {
         self.userData = userData
         
         super.init(nibName: nil, bundle: nil)
     }

     // If there is another required initializer, add it here
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login"
        // Load user data when needed
        if let userData = UserDataPersistence.shared.loadUserData(for: userData.uid) {
            // Use userData as needed
            print(userData)
        }
        print()

        setupUI()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
    }
    
  

    
    func setupUI() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),

            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    @objc func loginButtonTapped() {
        guard let usernameOrEmail = usernameTextField.text,
              let password = passwordTextField.text, !usernameOrEmail.isEmpty, !password.isEmpty else {
            showAlert(message: "Please enter both username/email and password correctly.")
            return
        }

        // Use Firebase authentication to sign in
        Auth.auth().signIn(withEmail: usernameOrEmail, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                // Handle login error
                print("Error logging in: \(error.localizedDescription)")
                self.showAlert(message: "Invalid username/email or password. Please try again.")
                return
            }

            // Login successful, fetch additional user data from Firebase database
            self.fetchUserData()

            print("User successfully logged in.")

            // Access userData here and perform necessary actions
            

            // Navigate to the next screen based on user role
            self.handleUserRoleAndNavigate()
        }
    }

    func handleUserRoleAndNavigate() {
        guard let role = userData.role else {
            // Handle the case where user role is not available
            return
        }

        var destinationViewController: UIViewController?

        switch role {
              case .model:
                         // User is a model
                         if userData.socialInfo.onlyFansLink == "" {
                             // Push to ModelsNavSelectorViewController if onlyFansLink is nil
                             if let managerData = managerData, let modelsData = managerData.managerData {
                              
                                 
                                 destinationViewController = ModelsNavSelectorViewController(managerData: loadedManagerData)
                             } else {
                                 // Handle the case where managerData or managerData.managerData is nil
                                 print("Error: managerData or managerData.managerData is nil")
                             }
                             let loadedManagerData = ManagerDataManager.shared.loadManagerData()
                             destinationViewController = ModelsNavSelectorViewController(managerData: loadedManagerData)
                             
                             print("grreg33\(loadedManagerData)")
                         }
                  
              case .manager:
                  // User is a model, navigate to NavSelectorViewController
                  destinationViewController = NavSelectorViewController(modelData: userData.modelData!)
              }

              // Push to the appropriate view controller
              if let destinationViewController = destinationViewController {
                  if let navSelectorVC = destinationViewController as? NavSelectorViewController {
                      navSelectorVC.userData = self.userData
                      navSelectorVC.modelData = userData.modelData!
                  } else if let modelsNavSelectorVC = destinationViewController as? ModelsNavSelectorViewController {
                      let loadedManagerData = ManagerDataManager.shared.loadManagerData()
                      modelsNavSelectorVC.modelData = loadedManagerData
                      modelsNavSelectorVC.managerData = loadedManagerData
                      modelsNavSelectorVC.manager?.imageData = managerData?.imageData
                      
                      
                      modelsNavSelectorVC.manager = managerData
                      
                      
                      print("grreg33\(loadedManagerData)")
                  } 
        
        
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        } else {
            // Handle the case where the destination view controller is not set
            print("Error: Unable to determine destination view controller.")
        }
    }



    // Fetch manager data
    func fetchManagerData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User ID is nil.")
            return
        }

        let databaseRef = Database.database().reference().child("managers").child(userId)

        databaseRef.observeSingleEvent(of: .value) { [weak self] (snapshot: DataSnapshot) in
            guard let self = self else { return }

            if let managerDataDict = snapshot.value as? [[String: Any]] {
                let managerData = managerDataDict.compactMap { Manager(dictionary: $0) }
                // Do something with the fetched managerData
                print("Fetched managerData:", managerData)

                // Call the delegate or update UI as needed
                self.delegate?.didFetchManagerData(managerData: managerData)
            } else {
                // Handle error or set default manager data
                print("Error fetching manager data.")
            }
        }
    }


    func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User ID is nil.")
            return
        }

        let databaseRef = Database.database().reference().child("users").child(userId)

        databaseRef.observeSingleEvent(of: .value) { [weak self] (snapshot: DataSnapshot) in
            guard let self = self else { return }

          

            if let userData = snapshot.value as? [String: Any],
                let role = userData["role"] as? String,
                let socialInfoDict = userData["socialInfo"] as? [String: String],
                let contactInfoDict = userData["contactInfo"] as? [String: String] {

                let socialInfo = SocialInfo(
                    instagram: socialInfoDict["instagram"] ?? "",
                    twitter: socialInfoDict["twitter"] ?? "",
                    onlyFansLink: socialInfoDict["onlyFansLink"] ?? ""
                )

                let contactInfo = ContactInfo(
                    email: contactInfoDict["email"] ?? "",
                    phoneNumber: contactInfoDict["phoneNumber"] ?? ""
                )

                self.userData = UserData(
                    uid: userId,
                    socialInfo: socialInfo,
                    role: UserRole(rawValue: role) ?? .manager, // Replace "yourNewStringValue" with the updated string value
                    numberOfModels: nil,
                    managerName: nil,
                    modelData: self.userData.modelData,
                    contactInfo: contactInfo
                )

                // Save the user data to UserDefaults
                UserDataPersistence.shared.saveUserData(userData: self.userData)

                // Call the delegate to notify about the sign-in
                self.delegate?.didSignIn(userData: self.userData)

                // ... rest of the code remains unchanged
            }
        }

    }


    // In your login function, set the delegate
  
    // In your login function, set the delegate
    // In your login function, set the delegate
    func login(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
            // ... (existing code)

            if let uid = authResult?.user.uid {
                let sc = AddModelLinksViewController(numberOfModels: 0)
                // Assuming LoginViewController has a delegate property

                // Create an empty array for modelData
             

                self?.delegate?.didSignIn(userData: UserData(uid: uid, socialInfo: SocialInfo(instagram: "", twitter: "", onlyFansLink: ""),
                                                              role: UserRole(rawValue: "role") ?? .manager,
                                                             numberOfModels: nil, managerName: nil, modelData: self!.userData.modelData,
                                                              contactInfo: ContactInfo(email: "", phoneNumber: "")))
                self?.fetchManagerData()
                
                
                
                // ... (rest of the code)
            }
        }
    }

    


    @objc func createAccountButtonTapped() {
        // Handle create account button tapped
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
// next add the userdata as well make sure its not nil so we can pass it through
