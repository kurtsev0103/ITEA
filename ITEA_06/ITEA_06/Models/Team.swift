//
//  Team.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 11/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

let countPlayers = 10

let teams = Team.createdTeams()

class Team {
    
    let nameTeam:   String
    let imageTeam:  String
    
    var players = [Player]()
    var matches = [Match]()
    
    init(nameTeam: String, imageTeam: String) {
        self.nameTeam =  nameTeam
        self.imageTeam = imageTeam
    }
    
    static func createdTeams() -> [Team] {
        var array = [Team]()
        
        let team1   = Team(nameTeam: "Atletic",     imageTeam: "team1")
        let team2   = Team(nameTeam: "Dinamo",      imageTeam: "team2")
        let team3   = Team(nameTeam: "Dinas",       imageTeam: "team3")
        let team4   = Team(nameTeam: "Skwitch",     imageTeam: "team4")
        let team5   = Team(nameTeam: "Minsk",       imageTeam: "team5")
        let team6   = Team(nameTeam: "Malanka",     imageTeam: "team6")
        let team7   = Team(nameTeam: "Orel",        imageTeam: "team7")
        let team8   = Team(nameTeam: "Junior",      imageTeam: "team8")
        let team9   = Team(nameTeam: "Aturn",       imageTeam: "team9")
        let team10  = Team(nameTeam: "Standart",    imageTeam: "team10")
        
        array += [team1, team2, team3, team4, team5, team6, team7, team8, team9, team10]

        for team in array {
            for _ in 0..<countPlayers {
                let player = Player(name:    names.randomElement()!,
                                    surname: surnames.randomElement()!,
                                    team:    team,
                                    photoName: "avatar",
                                    countryName: country.randomElement()!,
                                    soccerPrice: String(Int.random(in: 100...900)) + ".000 $",
                                    age: Int.random(in: 18..<40))
                team.players.append(player)
            }
        }
        
        return array
    }
    
}
