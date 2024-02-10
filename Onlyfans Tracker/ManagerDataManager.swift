//
//  ManagerDataManager.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/10/24.
//

import Foundation
import UIKit



class ManagerDataManager {
    static let shared = ManagerDataManager()

    private let userDefaults = UserDefaults.standard
    private let managerDataKey = "ManagerData"

    private init() {}

    func saveManagerData(_ managerData: [Manager]) {
        do {
            let managerDataEncoded = try JSONEncoder().encode(managerData)
            userDefaults.set(managerDataEncoded, forKey: managerDataKey)
            userDefaults.synchronize()
        } catch {
            print("Error encoding manager data: \(error)")
        }
    }

    func loadManagerData() -> [Manager] {
        guard let managerDataEncoded = userDefaults.data(forKey: managerDataKey) else {
            return []
        }

        do {
            let loadedManagerData = try JSONDecoder().decode([Manager].self, from: managerDataEncoded)
            return loadedManagerData
        } catch {
            print("Error decoding manager data: \(error)")
            return []
        }
    }
}
