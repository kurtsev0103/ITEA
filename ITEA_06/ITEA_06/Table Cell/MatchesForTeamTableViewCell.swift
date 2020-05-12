//
//  MatchesForTeamTableViewCell.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 12/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class MatchesForTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamsNames: UILabel!
    @IBOutlet weak var firstTeamScore: UILabel!
    @IBOutlet weak var secondTeamScore: UILabel!
    
    static let identifier = "MatchesForTeamTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchesForTeamTableViewCell", bundle: nil)
    }
    
    func configure(match: Match) {
        
        let str = match.firstTeam.nameTeam + " - " + match.secondTeam.nameTeam
        self.teamsNames.text = str
        self.firstTeamScore.text = String(match.firstTeamGoals)
        self.secondTeamScore.text = String(match.secondTeamGoals)        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
