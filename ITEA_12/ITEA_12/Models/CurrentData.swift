//
//  CurrentTeam.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 03/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

// MARK: - CurrentData
struct CurrentData: Codable {
    let api: API
}

// MARK: - API
struct API: Codable {
    let teams: [TeamElement]?
    let statistics: TeamStatistics?
}

// MARK: - TeamElement
struct TeamElement: Codable {
    
    let teamID: Int
    let name: String
    let logo: String
    let country: String
    let founded: Int

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case name, logo, country, founded
    }
}

// MARK: - TeamStatistics
struct TeamStatistics: Codable {
    let matchs: Matchs
}

// MARK: - Matchs
struct Matchs: Codable {
    let matchsPlayed, wins, draws, loses: GoalsAgainst
}

// MARK: - GoalsAgainst
struct GoalsAgainst: Codable {
    let home, away, total: Int
}
