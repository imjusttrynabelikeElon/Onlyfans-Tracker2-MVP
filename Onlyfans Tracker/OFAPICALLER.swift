//
//  OFAPICALLER.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/21/24.
//

import Foundation




import Foundation

class OnlyFansAPIClient {

    let baseURL = "https://api.apify.com/v2/datasets/OG7F5xvJMclc6GAM3/items?clean=true&format=json"

    func fetchOnlyFansProfiles(completion: @escaping (Result<[OnlyFansProfile], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let profiles = try JSONDecoder().decode([OnlyFansProfile].self, from: data)
                completion(.success(profiles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
