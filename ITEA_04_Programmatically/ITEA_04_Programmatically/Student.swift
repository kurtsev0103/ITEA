//
//  Student.swift
//  ITEA_04_Programmatically
//
//  Created by Oleksandr Kurtsev on 07/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

let countStudents = 100

let manNames = ["Oliver", "Jake", "Noah", "James", "Jack", "Connor", "Liam", "John", "Harry", "Callum",
                "Mason", "Joe", "Jacob", "Jacob", "Daniel", "Oscar", "Kyle", "William", "Thomas", "James"]

let womenNames = ["Mia", "Emma", "Mary", "Olivia", "Lily", "Isla", "Bethany", "Sophia", "Jessica", "Ava",
                  "Sarah", "Tracy", "Evelyn", "Lauren", "Megan", "Linda", "Poppy", "Evie", "Alla", "Olga"]

let surnames = ["Smith", "Brown", "Jones", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Hall", "Hill",
                "Allen", "Young", "King", "Lopez", "Scott", "Green", "Adams", "Baker", "Nelson", "Young"]

let manPhotos = ["face1", "face2", "face3", "face6", "face7"]

let womanPhotos = ["face4", "face5", "face8", "face9", "face10"]

class Student {
    
    enum Gender {
        case Man, Woman
    }
    
    let gender:  Gender
    let name:    String
    let surname: String
    let phone:   UInt
    let photo:   UIImage
    
    var fullName : String {
        return name + " " + surname
    }
    
    init(gender: Gender, name: String, surname: String, phone: UInt, photo: UIImage) {
        self.gender = gender
        self.name = name
        self.surname = surname
        self.phone = phone
        self.photo = photo
    }

    static func createdStudents() -> [Student] {
        var students = [Student]()
        
        for _ in 0..<countStudents {
            students.append(returnRandomStudent())
        }

        return students
    }
    
    static private func returnRandomStudent() -> Student {
        let random = Int(arc4random() % 2)
        if random == 0 {
            return Student(gender: .Man,
                           name: manNames.randomElement()!,
                           surname: surnames.randomElement()!,
                           phone: returnRandomNumber(),
                           photo: returnRandomPhoto(gender: .Man))
        } else {
            return Student(gender: .Woman,
                           name: womenNames.randomElement()!,
                           surname: surnames.randomElement()!,
                           phone: returnRandomNumber(),
                           photo: returnRandomPhoto(gender: .Woman))
        }
    }
    
    static private func returnRandomNumber() -> UInt {
        var number = "38050"
        for _ in 0...6 {
            number += String(arc4random_uniform(10))
        }
        return UInt(number)!
    }
    
    static private func returnRandomPhoto(gender: Gender) -> UIImage {
        switch gender {
        case .Man:   return UIImage(named: manPhotos.randomElement()!)!
        case .Woman: return UIImage(named: womanPhotos.randomElement()!)!
        }
    }

}
