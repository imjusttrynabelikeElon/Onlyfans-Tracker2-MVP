//
//  UserData.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/1/24.
//

import Foundation
import UIKit



struct UserData: Encodable, Decodable {
    var role: String?
    var numberOfModels: Int?
    var managerName: String?
    var modelData: [[String: String]]?
    // Add other properties as needed
}

