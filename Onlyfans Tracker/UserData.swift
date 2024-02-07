//
//  UserData.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/1/24.
//

import Foundation
import UIKit



struct UserData: Codable {
    var uid: String // Add this property
    var socialInfo: SocialInfo
    var role: String?
    var numberOfModels: Int?
    var managerName: String?
    var modelData: [Model]?
    var contactInfo: ContactInfo

    // Other properties as needed

    init(uid: String, socialInfo: SocialInfo, role: String?, numberOfModels: Int?, managerName: String?, modelData: [Model]?, contactInfo: ContactInfo) {
        self.uid = uid
        self.socialInfo = socialInfo
        self.role = role
        self.numberOfModels = numberOfModels
        self.managerName = managerName
        self.modelData = modelData
        self.contactInfo = contactInfo
    }
}



struct SocialInfo: Codable {
    var instagram: String
    var twitter: String
    var onlyFansLink: String
    // other properties as needed
}

struct ContactInfo: Codable {
    var email: String
    var phoneNumber: String
    // other properties as needed
}
