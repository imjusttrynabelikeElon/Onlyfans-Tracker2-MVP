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
    var role: UserRole?
    var numberOfModels: Int?
    var managerName: String?
    var modelData: [Model]?
    var contactInfo: ContactInfo

    // Add the property for emptyModelData
    var emptyModelData: [Model] = []

    init(uid: String, socialInfo: SocialInfo, role: UserRole, numberOfModels: Int?, managerName: String?, modelData: [Model]?, contactInfo: ContactInfo) {
        self.uid = uid
        self.socialInfo = socialInfo
        self.role = role
        self.numberOfModels = numberOfModels
        self.managerName = managerName

        // Check if modelData is nil and initialize emptyModelData accordingly
        if let modelData = modelData {
            self.modelData = modelData
        } else {
            self.modelData = []
        }

        // Initialize emptyModelData with the same data as modelData
        self.emptyModelData = self.modelData ?? []

        self.contactInfo = contactInfo
    }

}

// Define your UserRole enum if you haven't already
enum UserRole: String, Codable {
    case manager
    case model
    // Add other cases as needed
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

