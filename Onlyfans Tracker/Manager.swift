//
//  Manager.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/2/24.
//

import Foundation
import UIKit

import UIKit

struct Manager: Codable {
    var name: String
    var phoneNumber: String
    var imageData: Data?
    var email: String?
    var instagram: String?
    var twitter: String?
    var managerData: [Manager]?
    
    let imageDataKey = "ImageDataKey"

    // Additional properties and methods as needed

    init(name: String, phoneNumber: String, email: String?, imageData: Data? = nil, managerData: [Manager]? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.imageData = imageData
        self.managerData = managerData
    }
    
    init(dictionary: [String: Any]) {
           self.name = dictionary["name"] as? String ?? ""
           self.phoneNumber = dictionary["phoneNumber"] as? String ?? ""
           self.email = dictionary["email"] as? String
           self.imageData = dictionary["imageData"] as? Data
           self.instagram = dictionary["instagram"] as? String
           self.twitter = dictionary["twitter"] as? String
        

           // Assuming "managerData" is an array of dictionaries
           if let managerDataDict = dictionary["managerData"] as? [[String: Any]] {
               self.managerData = managerDataDict.compactMap { Manager(dictionary: $0) }
           } else {
               self.managerData = []
           }
       }

    // Additional methods for working with images
    func getImage() -> UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }

    static func saveCurrentManager(_ manager: Manager) {
         var managerData = ManagerDataPersistence.shared.loadManagerData()
         if let index = managerData.firstIndex(where: { $0.name == manager.name }) {
             managerData[index] = manager
         } else {
             managerData.append(manager)
         }
         ManagerDataPersistence.shared.saveManagerData(managerData)
     }

     static func loadAllManagers() -> [Manager] {
         return ManagerDataPersistence.shared.loadManagerData()
     }
    
    // Decoding from a dictionary
    static func decode(from dictionary: [String: Any]) -> Manager? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
            let manager = try JSONDecoder().decode(Manager.self, from: jsonData)
            return manager
        } catch {
            print("Error decoding manager: \(error)")
            return nil
        }
    }
}
