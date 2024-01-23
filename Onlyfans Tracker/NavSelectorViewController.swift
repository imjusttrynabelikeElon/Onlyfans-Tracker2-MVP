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
        imageView.contentMode = .scaleAspectFill
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
        avatarImageView.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8), // Adjust the multiplier to your desired size
            avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8) // Adjust the multiplier to your desired size
        ])
    }


    func configure(with avatarURL: URL) {
        avatarImageView.sd_setImage(with: avatarURL, completed: nil)
    }
}


class NavSelectorViewController: UICollectionViewController {
    let avatarURL = URL(string: "https://public.onlyfans.com/files/1/1t/1tf/1tf7bdqagp5v8xeqw5cbrxut4vsjbc6a1679622331/63758808/avatar.jpg")!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.reuseIdentifier)
        collectionView.dataSource = self
        title = "Your Clients"
        
        
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

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Avatar tapped!")

        // Create an instance of SelectOptionViewController
        let selectOptionViewController = SelectOptionViewController()

        // Push the SelectOptionViewController onto the navigation stack
        navigationController?.pushViewController(selectOptionViewController, animated: true)
    }

    @objc func avatarTapped() {
        print("Avatar tapped!")

        // Create an instance of SelectOptionViewController
        let selectOptionViewController = SelectOptionViewController()

        // Push the SelectOptionViewController onto the navigation stack
        navigationController?.pushViewController(selectOptionViewController, animated: true)
    }

  
}
