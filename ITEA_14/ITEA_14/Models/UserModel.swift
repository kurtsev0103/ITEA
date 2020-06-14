//
//  AppDelegate.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

struct UserModel {
    
    var id: String
    var name: String
    var address: String
    var photoString: String
    var bornDate: String
    var height: String
    var phone: String
    
    var representation: [String: Any] {
        var rep = ["id": id]
        rep["name"] = name
        rep["address"] = address
        rep["photoString"] = photoString
        rep["bornDate"] = bornDate
        rep["height"] = height
        rep["phone"] = phone
        return rep
    }
}
