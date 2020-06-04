//
//  TeamsTableViewCell.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 03/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
        
    static let identifier = "TeamsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TeamsTableViewCell", bundle: nil)
    }
    
    func configure(withTeam team: Team) {
        nameLabel.text = team.teamName
        NetworkManager().downloadImage(withURL: team.teamLogo) { image in
            self.logoImageView.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
