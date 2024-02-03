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
    var image: UIImage?
    var email: String?
    var instagram: String?
    var twitter: String?

    init(name: String, phoneNumber: String, email: String?, image: UIImage? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.image = image
    }
}
