//
//  NetworkManager.swift
//  ITEA_11
//
//  Created by Oleksandr Kurtsev on 02/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

class NetworkManager {
    
    var onCompletion: ((CurrentUser) -> Void)?
    
    func fetchCurrentUser() {
        let urlString = "https://fakemyapi.com/api/fake?id=\(id)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentUser =  self.parseJSON(with: data) {
                    self.onCompletion?(currentUser)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(with data: Data) -> CurrentUser? {
        let decoder = JSONDecoder()
        
        do {
            let currentUserData = try decoder.decode(CurrentUserData.self, from: data)
            guard let currentUser = CurrentUser(currentUserData: currentUserData) else { return nil }
            return currentUser
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
