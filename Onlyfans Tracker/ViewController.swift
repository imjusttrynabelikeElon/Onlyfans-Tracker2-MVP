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
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    let photosCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    let videosCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    let favoritedCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAndPrintOnlyFansData()
        view.backgroundColor = .lightGray
    }

    func setupUI() {
        // Add UI elements to the view
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(photosCountLabel)
        view.addSubview(videosCountLabel)
        view.addSubview(favoritedCountLabel)

        // Set up constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        photosCountLabel.translatesAutoresizingMaskIntoConstraints = false
        videosCountLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritedCountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Name label at the top
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // Username label below name
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // Photos Count label below username
            photosCountLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            photosCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // Videos Count label below photos count
            videosCountLabel.topAnchor.constraint(equalTo: photosCountLabel.bottomAnchor, constant: 10),
            videosCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // Favorited Count label below videos count
            favoritedCountLabel.topAnchor.constraint(equalTo: videosCountLabel.bottomAnchor, constant: 10),
            favoritedCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
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
                        self.nameLabel.text = "Name: \(self.name)"
                        self.usernameLabel.text = "Username: \(self.username)"
                        self.photosCountLabel.text = "Photos Count: \(self.photosCount)"
                        self.videosCountLabel.text = "Videos Count: \(self.videosCount)"
                        self.favoritedCountLabel.text = "Favorited Count: \(self.favoritedCount)"
                    }
                }

            case .failure(let error):
                print("Error fetching OnlyFans profiles: \(error)")
            }
        }
    }
}
