//
//  SignUPViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//


import UIKit
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {

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

        // If all checks pass, proceed with user registration in Firebase
        signUp(username: username, email: email, password: password)
    }

    func signUp(username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                // Handle error during authentication
                print("Error creating user: \(error.localizedDescription)")
                self.showAlertt(message: "The email address is already in use by another account")
                return
            }

            // Authentication successful
            if let uid = authResult?.user.uid {
                // Create a reference to the Firebase database
                let databaseRef = Database.database().reference().child("users").child(uid)

                // Save additional user data to the database
                let userData: [String: Any] = ["username": username, "email": email, "password": password]

                // You can add more fields to the userData dictionary as needed
                // ...

                // Save user data under a node named with the user's UID
                databaseRef.setValue(userData)

                // Print user details
                print("User successfully registered and authenticated.")
                print("User ID: \(uid)")
                print("Username: \(username)")
                print("Email: \(email)")
                print("Password: \(password)")

                // After successful signup, navigate to the OnboardingViewController
                let onboardingViewController = OnboardingViewController()
                self.navigationController?.pushViewController(onboardingViewController, animated: true)
            }
        }
    }


  

    // ... rest of the code remains unchanged


    func showAlertt(message: String) {
        let alert = UIAlertController(title: "Invalid", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


    @objc func signInButtonTapped() {
        let loginViewController = LoginViewController() // Instantiate your LoginViewController
        navigationController?.pushViewController(loginViewController, animated: true)
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
