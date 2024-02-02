//
//  ModelsNavSelectorViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/1/24.
//

import Foundation
import UIKit

import UIKit

class ModelsNavSelectorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModelCell.reuseIdentifier, for: indexPath) as! ModelCell
        
        let model = modelData[indexPath.item]
        
        if let modelImage: UIImage = model.image {
            cell.imageView.image = modelImage
        } else {
            cell.imageView.image = UIImage(named: "default_avatar")
        }
        
        // Customize other cell properties as needed
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          // Handle tap on a collection view cell
          print("Cell tapped at index: \(indexPath.item)")

          // Add blink animation to the selected cell
          if let cell = collectionView.cellForItem(at: indexPath) as? ModelCell {
              UIView.animate(withDuration: 0.1, animations: {
                  cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
              }) { _ in
                  UIView.animate(withDuration: 0.1) {
                      cell.transform = .identity
                  }
              }
          }

          // Retrieve the selected Manager
          let selectedManager = modelData[indexPath.item]

          // Get the reference to the storyboard
          let storyboard = UIStoryboard(name: "Main", bundle: nil)  // Replace "Main" with your actual storyboard name

          // Instantiate ManagerSelectOptionViewController from the storyboard
          if let managerSelectOptionViewController = storyboard.instantiateViewController(withIdentifier: "ManagerSelectOptionViewController") as? ManagerSelectOptionViewController {
              // Pass the selected Manager data to the next view controller
              managerSelectOptionViewController.selectedManager = selectedManager

              // Push ManagerSelectOptionViewController onto the navigation stack
              navigationController?.pushViewController(managerSelectOptionViewController, animated: true)
          }
      }






        
     
    

    // ... (your existing code)

    var modelData: [Manager] = []  // Ensure Model struct is defined
    
    var managerName: String?
    var managerImage: UIImage?
    var managerImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tap On Your Manager"

        populateModelData()
        
        // ... (your existing code)

        // Create manager image view
        managerImageView = UIImageView()
        managerImageView.backgroundColor = .lightGray
        managerImageView.contentMode = .scaleAspectFill
        managerImageView.layer.cornerRadius = 8.0
        managerImageView.layer.masksToBounds = true

        if let managerImage = managerImage {
                 managerImageView.image = managerImage
            
             } else {
                 managerImageView.image = UIImage(named: "default_avatar")
             }

             // ... (your existing code)
        // Set up tap gesture recognizer for managerImageView
              let tapGesture = UITapGestureRecognizer(target: self, action: #selector(managerImageTapped))
              managerImageView.isUserInteractionEnabled = true
              managerImageView.addGestureRecognizer(tapGesture)

         
        // Set up constraints for managerImageView
        managerImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(managerImageView)
        
        

        NSLayoutConstraint.activate([
            managerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            managerImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            managerImageView.widthAnchor.constraint(equalToConstant: 200.0), // Adjust the width as needed
            managerImageView.heightAnchor.constraint(equalToConstant: 200.0) // Adjust the height as needed
        ])
        
        view.backgroundColor = .white
    }
    
    func populateModelData() {
        // Create instances of Manager and populate the modelData array
        let manager1 = Manager(name: "Manager 1", phoneNumber: "123-456-7890", image: UIImage(named: "manager1_image"))
        let manager2 = Manager(name: "Manager 2", phoneNumber: "987-654-3210", image: UIImage(named: "manager2_image"))
        // Add other managers as needed

        // Populate the modelData array
        modelData = [manager1, manager2]
    }

    // ... (your existing code)
    
    @objc private func managerImageTapped() {
          // Handle tap on managerImageView
          print("Manager Image tapped!")

        // Create an instance of SelectOptionViewController
        let ManagerSelectOptionViewController = ManagerSelectOptionViewController()

        // Push the SelectOptionViewController onto the navigation stack
        navigationController?.pushViewController(ManagerSelectOptionViewController, animated: true)
      }
}

// Function to populate the modelData array with instances of Manager
