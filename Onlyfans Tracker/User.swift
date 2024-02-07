//
//  User.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/3/24.
//

import Foundation
import UIKit



class User: Codable {
    var uid: String
    var username: String
    var email: String
    var managers: [Manager]
    var models: [Model]

    init(uid: String, username: String, email: String) {
        self.uid = uid
        self.username = username
        self.email = email
        self.managers = []
        self.models = []
    }
}

