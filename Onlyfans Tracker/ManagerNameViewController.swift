//
//  ManagerNameViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/31/24.
//

import UIKit

class ManagerNameViewController: UIViewController, UITextFieldDelegate {
    var delegate: QuestionViewControllerDelegate?

    private var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false // Disable initially
        return button
    }()

    private var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter manager's name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Whats your Manager's name?"
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(textField)
        view.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.3),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            confirmButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
            confirmButton.widthAnchor.constraint(equalToConstant: 120),
        ])

        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        textField.delegate = self
    }

    @objc private func confirmButtonTapped() {
          guard let managerName = textField.text else { return }
          delegate?.didEnterManagerName(managerName)

          let addLinksVC = AddLinksViewController()
          navigationController?.pushViewController(addLinksVC, animated: true)
      }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        confirmButton.isEnabled = !newText.isEmpty
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        confirmButton.isEnabled = !textField.text!.isEmpty
    }
}
