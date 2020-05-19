//
//  TeamTableViewCell.swift
//  ITEA_08
//
//  Created by Oleksandr Kurtsev on 18/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    static let identifier = "TeamTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TeamTableViewCell", bundle: nil)
    }
    
    func configure(with team: Team) {
        teamNameLabel.text = team.name
        teamImageView.image = UIImage(named: team.image!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
