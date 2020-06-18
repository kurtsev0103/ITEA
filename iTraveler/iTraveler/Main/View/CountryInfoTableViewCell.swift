//
//  CountryInfoTableViewCell.swift
//  iTraveler
//
//  Created by Oleksandr Kurtsev on 18/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class CountryInfoTableViewCell: UITableViewCell {

    static let identifier = "CountryInfoTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CountryInfoTableViewCell", bundle: nil)
    }
    
    func configure() {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        
//        nameLabel.font = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 20)
//        countryCodeLabel.font = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
