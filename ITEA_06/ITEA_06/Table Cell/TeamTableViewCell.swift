//
//  TeamTableViewCell.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 12/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    
    static let identifier = "TeamTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TeamTableViewCell", bundle: nil)
    }
    
    func configure(with team: Team) {
        self.nameLabel.text = team.nameTeam
        self.teamImageView.image = UIImage(named: team.imageTeam)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
