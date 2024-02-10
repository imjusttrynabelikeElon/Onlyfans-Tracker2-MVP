//
//  ManagerPersistence.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/9/24.
//

import Foundation
import UIKit



struct ManagerPersistence {
    static let shared = ManagerPersistence()

    private let userDefaults = UserDefaults.standard

    func saveManager(manager: Manager, for uid: String) {
        let key = "ManagerData_\(uid)"

        do {
            let managerEncoded = try JSONEncoder().encode(manager)
            userDefaults.set(managerEncoded, forKey: key)
            // Make sure to synchronize UserDefaults
            userDefaults.synchronize()
        } catch {
            print("Error encoding manager data: \(error)")
        }
    }

    func loadManager(for uid: String) -> Manager? {
        let key = "ManagerData_\(uid)"

        guard let managerEncoded = userDefaults.data(forKey: key) else {
            return nil
        }

        do {
            let loadedManager = try JSONDecoder().decode(Manager.self, from: managerEncoded)
            return loadedManager
        } catch {
            print("Error decoding manager data: \(error)")
            return nil
        }
    }
}

