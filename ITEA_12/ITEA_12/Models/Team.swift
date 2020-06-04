//
//  CurrentTeam.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 03/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

struct Team {
    
    let teamID: Int
    let teamName: String
    let teamLogo: String
    let teamCountry: String
    let teamFounded: Int
    
    init?(teamData: TeamElement) {
        teamID = teamData.teamID
        teamName = teamData.name
        teamCountry = teamData.country
        teamFounded = teamData.founded
        teamLogo = teamData.logo
    }
}
