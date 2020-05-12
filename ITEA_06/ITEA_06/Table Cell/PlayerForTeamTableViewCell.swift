//
//  PlayerForTeamTableViewCell.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 12/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class PlayerForTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    
    static let identifier = "PlayerForTeamTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PlayerForTeamTableViewCell", bundle: nil)
    }
    
    func configure(player: Player) {
        self.nameLabel.text = player.fullName
        self.countryImageView.image = UIImage(named: player.countryName)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
