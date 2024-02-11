//
//  ManagerStruct.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/9/24.
//

import Foundation
import Foundation
import UIKit

struct ManagerStruct: Codable {
    var name: String
    var phoneNumber: String
    var imageData: Data?  // Use Data to store image
    var email: String?
    var instagram: String?
    var twitter: String?

    // Additional properties and methods as needed

    init(name: String, phoneNumber: String, email: String?, imageData: Data? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.imageData = imageData
    }

    // Additional methods for working with images
    func getImage() -> UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
}
