//
//  CurrentUser.swift
//  ITEA_11
//
//  Created by Oleksandr Kurtsev on 02/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

struct CurrentUser {
    
    let firstName: String
    let lastName: String
    var fullName: String {
        return lastName + " " + firstName
    }
    
    let email: String
    let photo: String
    
    init?(currentUserData: CurrentUserData) {
        firstName = currentUserData.firstAme
        lastName = currentUserData.lastName
        email = currentUserData.email
        photo = currentUserData.photo
    }
}
