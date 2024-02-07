//
//  UserDataManager.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/5/24.
//

import Foundation
import UIKit



class UserDataManager {
    // Static method to create a shared instance for each user
    static func sharedInstance(forUID uid: String) -> UserDataManager {
        // Use the user's UID to create a unique key for UserDefaults
        let uniqueKey = "UserData_\(uid)"
        
        // Check if an instance already exists for this user
        if let existingInstance = instances[uniqueKey] {
            return existingInstance
        }
        
        // Create a new instance for this user
        let newInstance = UserDataManager(uniqueKey: uniqueKey)
        instances[uniqueKey] = newInstance
        return newInstance
    }
    
    // Dictionary to store instances for each user
    private static var instances: [String: UserDataManager] = [:]
    static let shared = UserDataManager(uniqueKey: "")
    private let userDefaults: UserDefaults
    private let userDataKey: String
    let uniqueKey: String
    
    private init(uniqueKey: String) {
        self.userDefaults = UserDefaults.standard
        self.userDataKey = uniqueKey
        self.uniqueKey = uniqueKey
    }

    var userData: UserData? {
        get {
            if let data = userDefaults.data(forKey: userDataKey),
               let userData = try? JSONDecoder().decode(UserData.self, from: data) {
                return userData
            }
            return nil
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                userDefaults.set(encodedData, forKey: userDataKey)
            }
        }
    }
// work with each user having their own data now
    func saveUserData(_ userData: UserData) {
        self.userData = userData
    }
    
    func updateSocialInfo(instagram: String?, twitter: String?, onlyFansLink: String?) {
           // Ensure userData is not nil before updating
           guard var userData = self.userData else {
               print("Error: UserData not available.")
               return
           }

           // Update socialInfo properties
        userData.socialInfo.instagram = instagram!
           userData.socialInfo.twitter = twitter!
           userData.socialInfo.onlyFansLink = onlyFansLink!

           // Save updated userData
           saveUserData(userData)
       }
    
    

    // Additional methods as needed...
    
    // Clear user data when needed (e.g., user logout)
    func clearUserData() {
        userDefaults.removeObject(forKey: userDataKey)
    }
    
}
