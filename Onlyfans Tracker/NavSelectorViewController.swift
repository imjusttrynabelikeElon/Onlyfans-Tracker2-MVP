//
//  NavSelectorViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//

import UIKit
import SDWebImage

class AvatarCell: UICollectionViewCell {
    static let reuseIdentifier = "AvatarCell"
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // Change content mode to scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 230.0), // Adjust constant to push down
            avatarImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 5.5), // Adjust multiplier for width
            avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 5.5) // Adjust multiplier for height
        ])
    }

    func updateConstraintsForOrientation() {
        // Check if the device is in landscape orientation
        let isLandscape = UIDevice.current.orientation.isLandscape

        // Adjust constraints accordingly
        if isLandscape {
            // Update constraints for landscape
            NSLayoutConstraint.deactivate([
                avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 230.0)
            ])
            
            NSLayoutConstraint.activate([
                avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 250.0), // Adjust top anchor in landscape
                avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                avatarImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 5.5),
                avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 5.5)
            ])
        } else {
            // Update constraints for portrait
            NSLayoutConstraint.deactivate([
                avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0)
            ])

            NSLayoutConstraint.activate([
                avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 230.0),
                avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                avatarImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 5.5),
                avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 5.5)
            ])
        }
    }

    func configure(with avatarURL: URL) {
        avatarImageView.sd_setImage(with: avatarURL, completed: nil)
    }
}

class NavSelectorViewController: UICollectionViewController {
    let avatarURL = URL(string: "https://public.onlyfans.com/files/1/1t/1tf/1tf7bdqagp5v8xeqw5cbrxut4vsjbc6a1679622331/63758808/avatar.jpg")!

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.reuseIdentifier)
        collectionView.dataSource = self
        title = "Model Navigataion Center"
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // Only one avatar in the collection view
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.reuseIdentifier, for: indexPath) as? AvatarCell else {
            fatalError("Unable to dequeue AvatarCell")
        }
        cell.configure(with: avatarURL)
        return cell
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()

        // Update constraints when the orientation changes
        if let visibleIndexPath = collectionView.indexPathsForVisibleItems.first,
           let visibleCell = collectionView.cellForItem(at: visibleIndexPath) as? AvatarCell {
            visibleCell.updateConstraintsForOrientation()
        }
    }
}
