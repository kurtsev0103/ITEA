//
//  MatchTableViewCell.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 11/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstTeamImage: UIImageView!
    @IBOutlet weak var secondTeamImage: UIImageView!
    @IBOutlet weak var firstTeamScore: UILabel!
    @IBOutlet weak var secondTeamScore: UILabel!
    
    static let identifier = "MatchTableViewCell"
        
    func configure(with match: Match) {
        self.firstTeamImage.image = UIImage(named: (match.firstTeam.imageTeam))
        self.secondTeamImage.image = UIImage(named: (match.secondTeam.imageTeam))
        self.firstTeamScore.text = String(match.firstTeamGoals)
        self.secondTeamScore.text = String(match.secondTeamGoals)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
