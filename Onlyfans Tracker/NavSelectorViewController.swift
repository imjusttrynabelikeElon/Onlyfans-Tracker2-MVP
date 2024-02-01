//
//  NavSelectorViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/22/24.
//

import UIKit
import SDWebImage

class NavSelectorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModelCell.reuseIdentifier, for: indexPath) as! ModelCell

        let model = modelData[indexPath.item]

        if let modelImage = model.image {
            cell.imageView.image = modelImage
        } else {
            cell.imageView.image = UIImage(named: "default_avatar")
        }

        return cell
    }
    
   
    var infoLabel: UILabel!
    var modelData: [Model] // Ensure Model struct is defined
    var collectionView: UICollectionView!
    
    init(modelData: [Model]) {
          self.modelData = modelData
          super.init(nibName: nil, bundle: nil)
      }

      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

    override func viewDidLoad() {
           super.viewDidLoad()

           title = "Tap On One Of Your Models"

           // ... (your existing code)

        // Create a layout for the collection view
              let layout = UICollectionViewFlowLayout()
              layout.scrollDirection = .vertical
              layout.minimumInteritemSpacing = 20.0
              layout.minimumLineSpacing = 20.0

              // Adjust the size of the collection view items
              let itemWidth = (view.bounds.width - 60.0) / 2.0 // Set the width based on your preference
              let itemHeight = itemWidth * 1.5 // Adjust the height based on your preference
              layout.itemSize = CGSize(width: itemWidth, height: itemHeight)

              // Create the collection view
              collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
              collectionView.backgroundColor = .clear
              collectionView.delegate = self
              collectionView.dataSource = self
              collectionView.register(ModelCell.self, forCellWithReuseIdentifier: ModelCell.reuseIdentifier)

              // Add the collection view to the view hierarchy
              view.addSubview(collectionView)

              // Set up constraints for the collection view
              collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
                  collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0), // Adjust the constant as needed
                  collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
                  collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
                  collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
              ])

              // Set background color
              view.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 1.0) // Adjust the color values


           // Customize navigation bar
           let darkPinkColor = UIColor(red: 219/255, green: 112/255, blue: 147/255, alpha: 1.0) // Dark pink color
           navigationController?.navigationBar.barTintColor = darkPinkColor
           navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]

           // Set the background color of the navigation bar title
           navigationController?.navigationBar.backgroundColor = darkPinkColor

           // MARK: - UICollectionViewDelegate

          
           // Create info label
           infoLabel = UILabel()
           infoLabel.text = "Tap On Model To View Her Features"
           infoLabel.textColor = .black
           infoLabel.textAlignment = .center
           infoLabel.font = UIFont.systemFont(ofSize: 23.0)
           infoLabel.numberOfLines = 0

           // Set up constraints for avatarButton
         

           // Set up constraints for infoLabel
           infoLabel.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(infoLabel)

           NSLayoutConstraint.activate([
               infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               infoLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 60.0)
           ])
       }

    // Inside NavSelectorViewController
    private func setupAvatars() {
        for (index, model) in modelData.enumerated() {
            let avatarButton = UIButton()

            if let modelImage = model.image {
                avatarButton.setImage(modelImage, for: .normal)
            } else {
                // Set a default image or handle the case when there is no image
                avatarButton.setImage(UIImage(named: "default_avatar"), for: .normal)
            }

            // Configure other avatarButton properties as needed
            avatarButton.tag = index
            avatarButton.addTarget(self, action: #selector(avatarTapped), for: .touchUpInside)

            // Calculate position based on the number of models
            let spacing: CGFloat = 20.0
            let avatarWidth = view.bounds.width * 0.2
            let totalSpacing = CGFloat(modelData.count - 1) * spacing
            let totalWidth = CGFloat(modelData.count) * avatarWidth + totalSpacing
            let startX = (view.bounds.width - totalWidth) / 2.0 + CGFloat(index) * (avatarWidth + spacing)

            // Set up constraints for avatarButton
            avatarButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(avatarButton)

            NSLayoutConstraint.activate([
                avatarButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -83),
                avatarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startX),
                avatarButton.widthAnchor.constraint(equalToConstant: avatarWidth),
                avatarButton.heightAnchor.constraint(equalToConstant: avatarWidth)
            ])
        }
    }


    @objc func avatarTapped() {
        print("Avatar tapped!")

        // Add flick animation
        UIView.animate(withDuration: 0.1, animations: {
          
        }) { _ in
            UIView.animate(withDuration: 0.1) {
               
            }
        }

        // Create an instance of SelectOptionViewController
        let selectOptionViewController = SelectOptionViewController()

        // Push the SelectOptionViewController onto the navigation stack
        navigationController?.pushViewController(selectOptionViewController, animated: true)
    }
}
