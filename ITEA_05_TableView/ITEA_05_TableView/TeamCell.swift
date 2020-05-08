//
//  TeamCell.swift
//  ITEA_05_TableView
//
//  Created by Oleksandr Kurtsev on 08/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {

    @IBOutlet weak var firstTeamView: UIImageView!
    @IBOutlet weak var secondTeamView: UIImageView!
    @IBOutlet weak var firstTeamScore: UILabel!
    @IBOutlet weak var secondTeamScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
