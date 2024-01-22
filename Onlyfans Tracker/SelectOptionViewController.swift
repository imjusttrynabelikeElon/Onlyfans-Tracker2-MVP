//
//  SelectOptionViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//

import UIKit

class SelectOptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Pick Option"
        setupButtons()
    }

    private func setupButtons() {
        let messageModelButton = createButton(withTitle: "Message Model")
        let callModelButton = createButton(withTitle: "Call Model")
        let modelDataButton = createButton(withTitle: "Model Data")
        let scheduleDatesButton = createButton(withTitle: "Schedule Dates")

        // StackView for vertical alignment
        let verticalStackView1 = UIStackView(arrangedSubviews: [messageModelButton, callModelButton])
        verticalStackView1.axis = .vertical
        verticalStackView1.distribution = .fillEqually
        verticalStackView1.spacing = 420.0

        let verticalStackView2 = UIStackView(arrangedSubviews: [modelDataButton, scheduleDatesButton])
        verticalStackView2.axis = .vertical
        verticalStackView2.distribution = .fillEqually
        verticalStackView2.spacing = 420.0

        // StackView for horizontal alignment
        let horizontalStackView = UIStackView(arrangedSubviews: [verticalStackView1, verticalStackView2])
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 20.0

        view.addSubview(horizontalStackView)

        // Add constraints for stack view
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            horizontalStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        ])

        // Increase the height of the vertical stack views
        NSLayoutConstraint.activate([
            verticalStackView1.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, constant: -100),
            verticalStackView2.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, constant: -100)
        ])
    }

    private func createButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22.0)
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }

    @objc private func buttonTapped(sender: UIButton) {
          switch sender.title(for: .normal) {
          case "Message Model":
              // Handle Message Model button tap
              print("Message Model button tapped!")
              let phoneNumber = "sms://2123468423"
              if let url = URL(string: phoneNumber) {
                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
              }
          case "Call Model":
              // Handle Call Model button tap
              print("Call Model button tapped!")
              let phoneNumber = "tel://2123468423"
              if let url = URL(string: phoneNumber) {
                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
              }
          case "Model Data":
              // Handle Model Data button tap
              print("Model Data button tapped!")

              // Create an instance of DataViewController
              let dataViewController = DataViewController()

              // Push DataViewController onto the navigation stack
              navigationController?.pushViewController(dataViewController, animated: true)
          case "Schedule Dates":
              // Handle Schedule Dates button tap
              print("Schedule Dates button tapped!")
          default:
              break
          }
      }


}
