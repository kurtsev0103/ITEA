//
//  Student.swift
//  ITEA_03
//
//  Created by Oleksandr Kurtsev on 07/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class Student {
    
    let name : String
    let surname : String
    let email : String
    let age : Int
    let phone : UInt
    let photo : UIImage
    
    init(name: String, surname: String, email: String, age: Int, phone: UInt, photo: UIImage) {
        self.name = name
        self.surname = surname
        self.email = email
        self.age = age
        self.phone = phone
        self.photo = photo
    }

}
