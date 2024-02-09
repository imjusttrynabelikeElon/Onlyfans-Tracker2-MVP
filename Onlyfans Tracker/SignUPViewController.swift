//
//  SignUPViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController, AuthenticationDelegate, AddModelLinkssDelegate, AddModelLinksDelegatee {
    func didTapNextButtonInAddModelLinks() {
        signUpButton.isHidden = true
    }
    
    private var authResult: AuthDataResult?
    // Create an empty array for modelData
               let emptyModelData: [Model] = []
    
    func didSaveSocialInfo(instagram: String?, twitter: String?, onlyFansLink: String?) {
        guard let uid = authResult?.user.uid else {
            // Handle the case where uid is not available
            return
        }

        // Load existing user data for the current user
        var userData = UserDataPersistence.shared.loadUserData(for: uid)

        // If there is no existing data, create a new instance
        if userData == nil {
            userData = UserData(
                uid: uid,
                socialInfo: SocialInfo(instagram: "", twitter: "", onlyFansLink: ""),
                role: UserRole(rawValue: "yourNewStringValue") ?? .model,
                numberOfModels: nil,
                managerName: nil,
                modelData: emptyModelData,
                contactInfo: ContactInfo(email: "", phoneNumber: "")
            )
        }

        // Update the social information
        userData?.socialInfo.instagram = instagram!
        userData?.socialInfo.twitter = twitter!
        userData?.socialInfo.onlyFansLink = onlyFansLink!

        // Save the updated user data
        UserDataPersistence.shared.saveUserData(userData: userData!)

        // Set userData and UserDataSingleton
        self.userData = userData
        UserDataSingleton.shared.uid = uid

        // Push to OnboardingViewController or perform other actions
        let onboardingViewController = OnboardingViewController()
        self.navigationController?.pushViewController(onboardingViewController, animated: true)
    }

    
    func didSignIn(userData: UserData) {
        print("UID after sign in: \(userData.uid)")
    }
    
    var userData: UserData?
    var instagram: String? = ""
    var twitter: String? = ""
    var onlyFansLink: String? = ""
    var modelData: [Model]?
    var userRole: UserRole?
   
      // Add a default initializer
  

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let emailTextField: UITextField = {
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

    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create Account"
        setupUI()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
      //  NotificationCenter.default.addObserver(self, selector: #selector(handleNextButtonTapped), name: .nextButtonTappedInAddModelLinks, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
              view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
         // Dismiss the keyboard
         view.endEditing(true)
     }

    func setupUI() {
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),

            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),

            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            signUpButton.trailingAnchor.constraint(equalTo: signInButton.leadingAnchor, constant: -10),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),

            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            signInButton.widthAnchor.constraint(equalTo: signUpButton.widthAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

   // @objc  func handleNextButtonTapped() {
          // Hide the sign-up button
     //     signUpButton.isHidden = true
     //   print("dbfbfdfdbdffdffdOUIHOHOIOIJ")
   //   }
    
    
    @objc func signUpButtonTapped() {
        // Check if all text fields are filled
        guard let username = usernameTextField.text,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Display an error message or alert indicating that all fields must be filled
            showAlertt(message: "Please fill in all fields.")
            return
        }

        
        // Check if the username is at least 5 characters long
        guard username.count >= 5 else {
            // Display an error message or alert indicating that the username must be at least 5 characters
            showAlertt(message: "Username must be at least 5 characters.")
            return
        }

        // Check if the email is valid
        guard isValidEmail(email) else {
            // Display an error message or alert indicating that the email is invalid
            showAlertt(message: "Invalid email format. Please use a valid Gmail address.")
            return
        }

        // If the email is valid, perform password validation
        guard password.count >= 5,
              password.rangeOfCharacter(from: .uppercaseLetters) != nil,
              password.rangeOfCharacter(from: .decimalDigits) != nil else {
            // Display an error message or alert indicating that the password is invalid
            showAlerttt(message: "Password must contain at least 5 characters, including at least one capital letter and one digit.")
            return
        }

        signUp(username: username, email: email, password: password, instagram: instagram!, twitter: twitter!, onlyFansLink: onlyFansLink!, modelData: nil, role: UserRole(rawValue: "yourNewStringValue") ?? .model, emptyModelData: emptyModelData)
    }
    
    

    func signUp(username: String, email: String, password: String, instagram: String?, twitter: String?, onlyFansLink: String?, modelData: [Model]?, role: UserRole, emptyModelData: [Model]) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                // Handle error during authentication
                print("Error creating user: \(error.localizedDescription)")
                self.showAlertt(message: "The email address is already in use by another account")
                return
            }

            // Save the authResult when authentication is successful
            self.authResult = authResult

            // After successful login or signup, set userData and UserDataManager
            if let uid = authResult?.user.uid {
                // Create an instance of UserData
                let userData = UserData(
                    uid: uid,
                    socialInfo: SocialInfo(instagram: instagram ?? "", twitter: twitter ?? "", onlyFansLink: onlyFansLink ?? ""),
                    role: role,
                    
                    numberOfModels: nil,
                    managerName: nil,
                    modelData: modelData, // Use the provided emptyModelData
    
                    contactInfo: ContactInfo(email: email, phoneNumber: "")
                )

                // Save userData using UserDataManager
                UserDataManager.shared.saveUserData(userData)

                // Set userData and UserDataSingleton
                self.userData = userData
                UserDataSingleton.shared.uid = uid

                // Push to OnboardingViewController
                let onboardingViewController = OnboardingViewController()
                self.navigationController?.pushViewController(onboardingViewController, animated: true)
            }
        }
    }

       // ... rest



  

    // ... rest of the code remains unchanged


    func showAlertt(message: String) {
        let alert = UIAlertController(title: "Invalid", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


    @objc func signInButtonTapped() {
        // Assuming you have a method to retrieve user data
          userData = UserDataManager.shared.userData

        if let loadedUserData = UserDataPersistence.shared.loadUserData(for: userData?.uid ?? "IUIHWEHIU") {
            userData = loadedUserData
        } else {
            // Handle the case where user data is not available
            print("Error: User data not available.")
        }

        // Push to LoginViewController
        if let userDataa = userData {
            let loginViewController = LoginViewController(userData: userDataa)
            loginViewController.delegate = self
            navigationController?.pushViewController(loginViewController, animated: true)
        } else {
            // Handle the case where user data is nil
            print("Error: User data not available.")
            
        }

    }




    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@gmail.com" // Adjust the pattern as needed
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func showAlerttt(message: String) {
        let alert = UIAlertController(title: "Invalid Password", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
}
