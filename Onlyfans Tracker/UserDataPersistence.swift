//
//  UserDataPersistence.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/3/24.
//

import Foundation
import UIKit


class UserDataPersistence {
    static let shared = UserDataPersistence()

    private let userDefaults = UserDefaults.standard

    func saveUserData(userData: UserData) {
        // Assuming userData.uid is a non-optional String
        let key = "UserData_\(userData.uid)"

        do {
            let userDataEncoded = try JSONEncoder().encode(userData)
            userDefaults.set(userDataEncoded, forKey: key)
            // Make sure to synchronize UserDefaults
            userDefaults.synchronize()
        } catch {
            print("Error encoding user data: \(error)")
        }
    }

    func loadUserData(for uid: String) -> UserData? {
        let key = "UserData_\(uid)"

        guard let userDataEncoded = userDefaults.data(forKey: key) else {
            return nil
        }

        do {
            let loadedUserData = try JSONDecoder().decode(UserData.self, from: userDataEncoded)
            return loadedUserData
        } catch {
            print("Error decoding user data: \(error)")
            return nil
        }
    }
}
