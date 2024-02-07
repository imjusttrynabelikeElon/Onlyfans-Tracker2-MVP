//
//  Model.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/1/24.
//

import Foundation
import UIKit





class Model: Codable {
    var onlyFansLink: String?
    var instagram: String?
    var email: String?
    var phoneNumber: String?
    var twitter: String?
    var image: Data? // Change UIImage to Data

    // Other properties...

    init(onlyFansLink: String?, image: UIImage? = nil) {
        self.onlyFansLink = onlyFansLink
        self.image = image?.pngData() // Convert UIImage to Data
    }

    // If you need to convert Data back to UIImage
    func getImage() -> UIImage? {
        if let imageData = image {
            return UIImage(data: imageData)
        }
        return nil
    }
}
