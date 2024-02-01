//
//  HowManyModelsViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/31/24.
//

import UIKit

class HowManyModelsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var delegate: QuestionViewControllerDelegate?

    private var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false // Disable initially
        return button
    }()

    private var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    private var options: [String] = []
    private var selectedOption: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        title = "How many models do you have?"
        
        options = (1...50).map { "\($0)" }
        options.append("50+")

        view.addSubview(pickerView)
        view.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.3),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            confirmButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
            confirmButton.widthAnchor.constraint(equalToConstant: 120),
        ])

        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)

        pickerView.delegate = self
        pickerView.dataSource = self
    }

    @objc private func confirmButtonTapped() {
          guard let selectedOption = selectedOption,
                let numberOfModels = Int(selectedOption) else { return }

          // Present AddModelLinksViewController for the specified number of models
          let addModelLinksVC = AddModelLinksViewController(numberOfModels: numberOfModels)
          navigationController?.pushViewController(addModelLinksVC, animated: true)
      }
    
    // MARK: - UIPickerViewDelegate and UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = options[row]
        confirmButton.isEnabled = true
    }
}
