//
//  PlayerTableViewCell.swift
//  ITEA_08
//
//  Created by Oleksandr Kurtsev on 18/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerCountryImageView: UIImageView!
    @IBOutlet weak var playerFullNameLabel: UILabel!
    @IBOutlet weak var playerAgeLabel: UILabel!
    
    static let identifier = "PlayerTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PlayerTableViewCell", bundle: nil)
    }
    
    func configure(with player: Player) {
        playerFullNameLabel.text = player.name! + " " + player.surname!
        playerCountryImageView.image = UIImage(named: player.countryImage!)
        playerAgeLabel.text = String(player.age) + " years"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
