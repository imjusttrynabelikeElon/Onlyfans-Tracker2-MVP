//
//  ModelsNavSelectorViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/1/24.
//

import Foundation
import UIKit

import UIKit

protocol ModelsNavSelectorDelegate: AnyObject {
    func didUpdateManagerData(_ manager: Manager)
}

class ModelsNavSelectorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var managerName: String?
     var managerImage: UIImage?
     var modelData: [Manager] = []  // Ensure Model struct is defined
    var managerImageView: UIImageView!
    weak var delegate: ModelsNavSelectorDelegate?
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard modelData.indices.contains(indexPath.item) else {
            // Handle the case where modelData is empty or index is out of bounds
            // You can return a default cell or handle it in a way that fits your logic
            return collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        }

        // Rest of your code to configure the cell using modelData
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModelCell.reuseIdentifier, for: indexPath) as! ModelCell
        let model = modelData[indexPath.item]

        // Assuming 'model' is an instance of the Manager class
        if let imageData: Data = model.imageData, let modelImage: UIImage = UIImage(data: imageData) {
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

               delegate?.didUpdateManagerData(selectedManager)
               // Push ManagerSelectOptionViewController onto the navigation stack
               navigationController?.pushViewController(managerSelectOptionViewController, animated: true)
           }
        
      }






        
     

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tap On Your Manager"

        // Initialize modelData with the passed manager data
        if let managerName = managerName, let managerImage = managerImage {
                  let currentManager = Manager(name: managerName, phoneNumber: "", email: "")
                  modelData.append(currentManager)
              }
        
        print(modelData)
        navigationItem.hidesBackButton = true
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
    
  
    @objc private func managerImageTapped() {
        // Handle tap on managerImageView
        print("Manager Image tapped!")

        // Create an instance of ManagerSelectOptionViewController
        let managerSelectOptionViewController = ManagerSelectOptionViewController()

        // Assuming modelData contains at least one manager (you might need to check for this)
        if let selectedManager = modelData.first {
            // Pass the selected Manager data to the next view controller
            managerSelectOptionViewController.selectedManager = selectedManager

            print(selectedManager)
            // Push ManagerSelectOptionViewController onto the navigation stack
            navigationController?.pushViewController(managerSelectOptionViewController, animated: true)
        }
    }

}

// Function to populate the modelData array with instances of Manager
