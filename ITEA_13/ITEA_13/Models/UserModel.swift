//
//  UserModel.swift
//  ITEA_13
//
//  Created by Oleksandr Kurtsev on 06/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

struct UserModel {
    var lastName = ""
    var telephone = [String]()
    var email = ""
    var address = Address()
    var firstName = ""
    var jobType = ""
    var photo = ""
    var title = ""
}

// MARK: - Address
struct Address {
    var city = ""
    var country = ""
    var street = ""
    var zipCode = ""
}
