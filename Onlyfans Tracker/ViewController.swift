//
//  ViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/21/24.
//


import UIKit

class ViewController: UIViewController {

    // Model data (replace with actual data)
    var name: String = ""
    var username: String = ""
    var photosCount: Int = 0
    var videosCount: Int = 0
    var favoritedCount: String = ""
    let onlyFansAPIClient = OnlyFansAPIClient()

    // UI Elements
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private static func createBorderedButton() -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        return button
    }

    // ...

    let nameLabel: UIButton = {
        let button = createBorderedButton()
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()

    let usernameLabel: UIButton = {
        let button = createBorderedButton()
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()

    let photosCountLabel: UIButton = {
        let button = createBorderedButton()
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()

    let videosCountLabel: UIButton = {
        let button = createBorderedButton()
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()

    let favoritedCountLabel: UIButton = {
        let button = createBorderedButton()
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()

    @objc func buttonTapped(_ sender: UIButton) {
        // Handle button tap, you can identify which button was tapped using sender.tag or other properties
        print("Button tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAndPrintOnlyFansData()
        view.backgroundColor = .lightGray
    }

    func setupUI() {
        // Add UI elements to the scroll view
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(usernameLabel)
        scrollView.addSubview(photosCountLabel)
        scrollView.addSubview(videosCountLabel)
        scrollView.addSubview(favoritedCountLabel)

        // Add scroll view to the main view
        view.addSubview(scrollView)

        // Set up constraints for scroll view
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // Set up constraints for UI elements within the scroll view
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        photosCountLabel.translatesAutoresizingMaskIntoConstraints = false
        videosCountLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritedCountLabel.translatesAutoresizingMaskIntoConstraints = false

        let labelWidthMultiplier: CGFloat = 0.4 // Adjusted width multiplier for smaller squares
        let labelHeightMultiplier: CGFloat = 0.15 // Adjusted height multiplier for smaller squares

        NSLayoutConstraint.activate([
            // Name label at the top left
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: labelWidthMultiplier),
            nameLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: labelHeightMultiplier),

            // Username label at the top right
            usernameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            usernameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            usernameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: labelWidthMultiplier),
            usernameLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: labelHeightMultiplier),

            // Photos Count label in the second row left
            photosCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            photosCountLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            photosCountLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: labelWidthMultiplier),
            photosCountLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: labelHeightMultiplier),

            // Videos Count label in the second row right
            videosCountLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            videosCountLabel.leadingAnchor.constraint(equalTo: photosCountLabel.trailingAnchor, constant: 20),
            videosCountLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: labelWidthMultiplier),
            videosCountLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: labelHeightMultiplier),

            // Favorited Count label in the third row left
            favoritedCountLabel.topAnchor.constraint(equalTo: photosCountLabel.bottomAnchor, constant: 20),
            favoritedCountLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            favoritedCountLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: labelWidthMultiplier),
            favoritedCountLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: labelHeightMultiplier),
        ])

        // Set content size of the scroll view
        let totalHeight = scrollView.subviews.reduce(0) { $0 + $1.bounds.height + 20 }
        scrollView.contentSize = CGSize(width: view.bounds.width, height: totalHeight)

        // Set the number of lines for the labels (buttons)
        nameLabel.titleLabel?.numberOfLines = 2
        usernameLabel.titleLabel?.numberOfLines = 2
        photosCountLabel.titleLabel?.numberOfLines = 2
        videosCountLabel.titleLabel?.numberOfLines = 2
        favoritedCountLabel.titleLabel?.numberOfLines = 2
    }





    func fetchAndPrintOnlyFansData() {
        onlyFansAPIClient.fetchOnlyFansProfiles { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let profiles):
                if let firstProfile = profiles.first {
                    // Update the properties with values from the fetched profile
                    self.name = firstProfile.name
                    self.username = firstProfile.username
                    self.photosCount = firstProfile.photosCount
                    self.videosCount = firstProfile.videosCount
                    self.favoritedCount = "\(firstProfile.favoritesCount)"

                    // Print the fetched data
                    print("Name: \(self.name)")
                    print("Username: \(self.username)")
                    print("Photos Count: \(self.photosCount)")
                    print("Videos Count: \(self.videosCount)")
                    print("Favorited Count: \(self.favoritedCount)")

                    // Update UI elements with the new values
                    DispatchQueue.main.async {
                        // Update UI elements with the new values
                        DispatchQueue.main.async {
                            self.nameLabel.setTitle("Name: \(self.name)", for: .normal)
                            self.usernameLabel.setTitle("Username: \(self.username)", for: .normal)
                            self.photosCountLabel.setTitle("Photos Count: \(self.photosCount)", for: .normal)
                            self.videosCountLabel.setTitle("Videos Count: \(self.videosCount)", for: .normal)
                            self.favoritedCountLabel.setTitle("Favorited Count: \(self.favoritedCount)", for: .normal)
                        }

                    }
                }

            case .failure(let error):
                print("Error fetching OnlyFans profiles: \(error)")
            }
        }
    }

    private static func createBorderedLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center // Set text alignment to center
        label.textColor = .black
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 8.0
        label.clipsToBounds = true
        return label
    }
}
