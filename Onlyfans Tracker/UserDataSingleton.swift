//
//  UserDataSingleton.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/4/24.
//

import Foundation
import UIKit



class UserDataSingleton {
    static let shared = UserDataSingleton()
    
    var uid: String
    var username: String
    var email: String
    var password: String
    var socialInfo: SocialInfo
    var role: String?
    var numberOfModels: Int?
    var managerName: String?
    var modelData: [Manager]?
    var contactInfo: ContactInfo
       var managerPhoneNumber: String?
       var managerEmail: String?
       var managerInstagram: String?
       var managerTwitter: String?
       var managerImage: UIImage?
    
    private init() {
        // Initialize your UserData here
        uid = ""
        username = ""
        email = ""
        password = ""
        socialInfo = SocialInfo(instagram: "", twitter: "", onlyFansLink: "")
        contactInfo = ContactInfo(email: "", phoneNumber: "")
    }
}

