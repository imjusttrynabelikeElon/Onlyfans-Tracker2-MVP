//
//  DataViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/21/24.
//

import UIKit

class DataViewController: UIViewController {

 
    // Model data (replace with actual data)
    // Model data (replace with actual data)
      var name: String = ""
      var username: String = ""
      var photosCount: Int = 0
      var videosCount: Int = 0
      var favoritedCount: String = ""
      var canLookStory: Bool = false
      var canCommentStory: Bool = false
      var hasNotViewedStory: Bool = false
      var isVerified: Bool = false
      var canPayInternal: Bool = false
      // Additional properties
      var hasScheduledStream: Bool = false
      var hasStream: Bool = false
      var hasStories: Bool = false

    let onlyFansAPIClient = OnlyFansAPIClient()

    // UI Elements
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let nameLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()

    let usernameLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()

    let photosCountLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()

    let videosCountLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()

    let favoritedCountLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()

    let canLookStoryLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()

    let canCommentStoryLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()

    let hasNotViewedStoryLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()

    let isVerifiedLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()

    let canPayInternalLabel: UILabel = {
        let label = createBorderedLabel()
        return label
    }()
    
    var hasScheduledStreamLabel: UILabel = {
          let label = createBorderedLabel()
          return label
      }()

      var hasStreamLabel: UILabel = {
          let label = createBorderedLabel()
          return label
      }()

      var hasStoriesLabel: UILabel = {
          let label = createBorderedLabel()
          return label
      }()

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
        scrollView.addSubview(canLookStoryLabel)
        scrollView.addSubview(canCommentStoryLabel)
        scrollView.addSubview(hasNotViewedStoryLabel)
        scrollView.addSubview(isVerifiedLabel)
        scrollView.addSubview(canPayInternalLabel)
        scrollView.addSubview(hasScheduledStreamLabel)
        scrollView.addSubview(hasStreamLabel)
        scrollView.addSubview(hasStoriesLabel)

        // Add scroll view to the main view
        view.addSubview(scrollView)

        // Set up constraints for scroll view
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        // Set up constraints for UI elements within the scroll view
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        photosCountLabel.translatesAutoresizingMaskIntoConstraints = false
        videosCountLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritedCountLabel.translatesAutoresizingMaskIntoConstraints = false
        canLookStoryLabel.translatesAutoresizingMaskIntoConstraints = false
        canCommentStoryLabel.translatesAutoresizingMaskIntoConstraints = false
        hasNotViewedStoryLabel.translatesAutoresizingMaskIntoConstraints = false
        isVerifiedLabel.translatesAutoresizingMaskIntoConstraints = false
        canPayInternalLabel.translatesAutoresizingMaskIntoConstraints = false
        hasScheduledStreamLabel.translatesAutoresizingMaskIntoConstraints = false
        hasStreamLabel.translatesAutoresizingMaskIntoConstraints = false
        hasStoriesLabel.translatesAutoresizingMaskIntoConstraints = false

        let labelWidthMultiplier: CGFloat = 0.8
        let labelHeightMultiplier: CGFloat = 0.1 // Adjusted height multiplier

        NSLayoutConstraint.activate([
            // Name label at the top
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: labelWidthMultiplier),
            nameLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: labelHeightMultiplier),

            // Username label below name
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            usernameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            usernameLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            usernameLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

            // Photos Count label below username
            photosCountLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            photosCountLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            photosCountLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            photosCountLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

            // Videos Count label below photos count
            videosCountLabel.topAnchor.constraint(equalTo: photosCountLabel.bottomAnchor, constant: 10),
            videosCountLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            videosCountLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            videosCountLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

            // Favorited Count label below videos count
            favoritedCountLabel.topAnchor.constraint(equalTo: videosCountLabel.bottomAnchor, constant: 10),
            favoritedCountLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            favoritedCountLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            favoritedCountLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

            // Can Look Story label below favorited count
            canLookStoryLabel.topAnchor.constraint(equalTo: favoritedCountLabel.bottomAnchor, constant: 10),
            canLookStoryLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            canLookStoryLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            canLookStoryLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

            // Can Comment Story label below Can Look Story
            canCommentStoryLabel.topAnchor.constraint(equalTo: canLookStoryLabel.bottomAnchor, constant: 10),
            canCommentStoryLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            canCommentStoryLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            canCommentStoryLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

            // Has Not Viewed Story label below Can Comment Story
            hasNotViewedStoryLabel.topAnchor.constraint(equalTo: canCommentStoryLabel.bottomAnchor, constant: 10),
            hasNotViewedStoryLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            hasNotViewedStoryLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            hasNotViewedStoryLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

            // Is Verified label below Has Not Viewed Story
            isVerifiedLabel.topAnchor.constraint(equalTo: hasNotViewedStoryLabel.bottomAnchor, constant: 10),
            isVerifiedLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            isVerifiedLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            isVerifiedLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

            // Can Pay Internal label below Is Verified
            canPayInternalLabel.topAnchor.constraint(equalTo: isVerifiedLabel.bottomAnchor, constant: 10),
            canPayInternalLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            canPayInternalLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            canPayInternalLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
            
            hasScheduledStreamLabel.topAnchor.constraint(equalTo: canPayInternalLabel.bottomAnchor, constant: 10),
                       hasScheduledStreamLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                       hasScheduledStreamLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
                       hasScheduledStreamLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

                       // Has Stream label below Has Scheduled Stream
                       hasStreamLabel.topAnchor.constraint(equalTo: hasScheduledStreamLabel.bottomAnchor, constant: 10),
                       hasStreamLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                       hasStreamLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
                       hasStreamLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),

                       // Has Stories label below Has Stream
                       hasStoriesLabel.topAnchor.constraint(equalTo: hasStreamLabel.bottomAnchor, constant: 10),
                       hasStoriesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                       hasStoriesLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
                       hasStoriesLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
        ])
    }


    override func viewDidAppear(_ animated: Bool) {
          scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
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
                    self.canLookStory = firstProfile.canLookStory
                    self.canCommentStory = firstProfile.canCommentStory
                    self.hasNotViewedStory = firstProfile.hasNotViewedStory
                    self.isVerified = firstProfile.isVerified
                    self.canPayInternal = firstProfile.canPayInternal
                    self.hasScheduledStream = firstProfile.hasScheduledStream
                    self.hasStream = firstProfile.hasStream
                    self.hasStories = firstProfile.hasStories
                  
                    // Print the fetched data
                    print("Name: \(self.name)")
                    print("Username: \(self.username)")
                    print("Photos Count: \(self.photosCount)")
                    print("Videos Count: \(self.videosCount)")
                    print("Favorited Count: \(self.favoritedCount)")
                    print("Can Look Story: \(self.canLookStory)")
                    print("Can Comment Story: \(self.canCommentStory)")
                    print("Has Not Viewed Story: \(self.hasNotViewedStory)")
                    print("Is Verified: \(self.isVerified)")
                    print("Can Pay Internal: \(self.canPayInternal)")
                    // Additional properties
                    print("Has Scheduled Stream: \(self.hasScheduledStream)")
                    print("Has Stream: \(self.hasStream)")
                    print("Has Stories: \(self.hasStories)")

                    // Update UI elements with the new values
                    DispatchQueue.main.async {
                        self.nameLabel.text = "Name: \(self.name)"
                        self.usernameLabel.text = "Username: \(self.username)"
                        self.photosCountLabel.text = "Photos Count: \(self.photosCount)"
                        self.videosCountLabel.text = "Videos Count: \(self.videosCount)"
                        self.favoritedCountLabel.text = "Favorited Count: \(self.favoritedCount)"
                        self.canLookStoryLabel.text = "Can Look Story: \(self.canLookStory)"
                        self.canCommentStoryLabel.text = "Can Comment Story: \(self.canCommentStory)"
                        self.hasNotViewedStoryLabel.text = "Has Not Viewed Story: \(self.hasNotViewedStory)"
                        self.isVerifiedLabel.text = "Is Verified: \(self.isVerified)"
                        self.canPayInternalLabel.text = "Can Pay Internal: \(self.canPayInternal)"
                        // Additional labels
                        self.hasScheduledStreamLabel.text = "Has Scheduled Stream: \(self.hasScheduledStream)"
                        self.hasStreamLabel.text = "Has Stream: \(self.hasStream)"
                        self.hasStoriesLabel.text = "Has Stories: \(self.hasStories)"
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
