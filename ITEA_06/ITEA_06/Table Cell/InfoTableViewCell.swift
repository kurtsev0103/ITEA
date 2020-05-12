//
//  InfoTableViewCell.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 11/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var namePlayer: UILabel!
    @IBOutlet weak var firstTeamGoal: UIImageView!
    @IBOutlet weak var secondTeamGoal: UIImageView!
    
    static let identifier = "InfoTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "InfoTableViewCell", bundle: nil)
    }
    
    func configure(player: Player, firstTeam: Team, secondTeam: Team) {
        self.namePlayer.text = player.fullName
        
        if player.team.nameTeam == firstTeam.nameTeam {
            self.firstTeamGoal.image = UIImage(named: "ball")
        } else {
            self.secondTeamGoal.image = UIImage(named: "ball")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
