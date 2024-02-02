//
//  Manager.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/2/24.
//

import Foundation
import UIKit



class Manager {
    var name: String
    var phoneNumber: String
    var image: UIImage?  // Add this property for the manager's image

    init(name: String, phoneNumber: String, image: UIImage? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.image = image
        
    
    }

}
