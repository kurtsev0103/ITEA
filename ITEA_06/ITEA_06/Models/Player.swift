//
//  Player.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 11/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

let names = ["Oliver", "Jake", "Noah", "James", "Jack", "Connor", "Liam", "John", "Harry", "Callum",
             "Mason", "Joe", "Jacob", "Jacob", "Daniel", "Oscar", "Kyle", "William", "Thomas", "James"]

let surnames = ["Smith", "Brown", "Jones", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Hall", "Hill",
                "Allen", "Young", "King", "Lopez", "Scott", "Green", "Adams", "Baker", "Nelson", "Young"]

let country = ["flag0", "flag1", "flag2", "flag3", "flag4", "flag5", "flag6", "flag7", "flag8"]

class Player {
    let name:        String
    let surname:     String
    var fullName:    String { return name + " " + surname }
    let photoName:   String
    let countryName: String
    let soccerPrice: String
    let age:         Int

    unowned var team: Team
    
    init(name: String, surname: String, team: Team, photoName: String, countryName: String, soccerPrice: String, age: Int) {
        self.name =         name
        self.surname =      surname
        self.team =         team
        self.photoName =    photoName
        self.countryName =  countryName
        self.soccerPrice =  soccerPrice
        self.age =          age
    }
}
