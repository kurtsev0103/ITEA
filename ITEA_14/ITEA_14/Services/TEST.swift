////
////  AppDelegate.swift
////  ITEA_14
////
////  Created by Oleksandr Kurtsev on 12/06/2020.
////  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
////
//
//import Foundation
//import SwiftyJSON
//
//class NetworkManager {
//    
//    static let shared = NetworkManager()
//    private let session = URLSession.shared
//    
//    func fetchJSONData(completionHandler: @escaping (_ user: UserModel) -> Void) {
//        let urlString = "https://fakemyapi.com/api/fake?id=\(apiID)"
//        guard let url = URL(string: urlString) else { return }
//    
//        session.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            if let data = data {
//                let user = self.parsingJSON(with: data)
//                completionHandler(user)
//            }
//        }.resume()
//    }
//    
//    func fetchImage(with urlString: String, completionHandler: @escaping (_ data: Data) -> Void) {
//        let imageURL = URL(string: urlString)
//        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
//        completionHandler(imageData)
//    }
//    
//    private func parsingJSON(with data: Data) -> UserModel {
//        let json = JSON(data)
//        var user = UserModel()
//        
//        user.title = json["title"].string!
//        user.firstName = json["first_ame"].string!
//        user.lastName = json["last_name"].string!
//        user.jobType = json["job_type"].string!
//        user.photo = json["photo"].string!
//        user.email = json["email"].string!
//        
//        var adress = Address()
//        adress.city = json["address"]["city"].string!
//        adress.country = json["address"]["country"].string!
//        adress.street = json["address"]["street"].string!
//        adress.zipCode = json["address"]["zip_code"].string!
//        
//        user.address = adress
//        
//        let telephoneArray = json["telephone"].array
//        for telephoneJSON in telephoneArray! {
//            user.telephone.append(telephoneJSON.string!)
//        }
//        
//        return user
//    }
//}
