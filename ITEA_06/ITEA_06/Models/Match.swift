//
//  Match.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 11/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

var matches = [Match]()

struct Match {
    
    var firstTeam: Team
    var secondTeam: Team
    var firstTeamGoals: Int
    var secondTeamGoals: Int

    var scoredGoal = [Player]()
    
    static func playMatch(firstTeam: Team, secondTeam: Team) -> Match? {
        if firstTeam.nameTeam != secondTeam.nameTeam {
                        
            var match = Match(firstTeam: firstTeam, secondTeam: secondTeam, firstTeamGoals: Int.random(in: 0..<5), secondTeamGoals: Int.random(in: 0..<5))
            
            if match.firstTeamGoals != 0 {
                for _ in 0..<match.firstTeamGoals {
                    match.scoredGoal.append(firstTeam.players.randomElement()!)
                }
            }
            
            if match.secondTeamGoals != 0 {
                for _ in 0..<match.secondTeamGoals {
                    match.scoredGoal.append(secondTeam.players.randomElement()!)
                }
            }
            
            match.scoredGoal.shuffle()
            firstTeam.matches.append(match)
            secondTeam.matches.append(match)

            return match
        }
        return nil
    }
        
}
