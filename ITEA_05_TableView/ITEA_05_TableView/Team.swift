//
//  Team.swift
//  ITEA_05_TableView
//
//  Created by Oleksandr Kurtsev on 08/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

let countTeams = 144

class Team {
    
    var imageTeam: UIImage
    
    init(imageTeam: UIImage) {
        self.imageTeam = imageTeam
    }
    
    static func createdTeams() -> [Team] {
        var teams = [Team]()
        
        for i in 0..<countTeams {
            
            let str = "team" + String(i)
            let team = Team(imageTeam: UIImage(named: str)!)
            
            teams.append(team)
        }

        return teams
    }
    
}
