//
//  MatchTableViewCell.swift
//  ITEA_08
//
//  Created by Oleksandr Kurtsev on 18/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstTeamNameLabel: UILabel!
    @IBOutlet weak var secondTeamNameLabel: UILabel!
    @IBOutlet weak var firstTeamScoreLabel: UILabel!
    @IBOutlet weak var secondTeamScoreLabel: UILabel!
    
    static let identifier = "MatchTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchTableViewCell", bundle: nil)
    }
    
    func configure(with match: Match) {
        firstTeamNameLabel.text = match.firstTeamName
        secondTeamNameLabel.text = match.secondTeamName
        firstTeamScoreLabel.text = String(match.firstTeamGoals)
        secondTeamScoreLabel.text = String(match.seconTeamGols)
        
        if match.firstTeamName == UserDefaults.standard.string(forKey: userNickKey) {
            firstTeamNameLabel.textColor = UIColor.systemYellow
        } else {
            secondTeamNameLabel.textColor = UIColor.systemYellow
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
