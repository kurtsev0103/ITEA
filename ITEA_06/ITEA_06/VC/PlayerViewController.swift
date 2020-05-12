//
//  PlayerViewController.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 12/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var teamImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = player.name
        addAllParams()
    }
    
    func addAllParams() {
        self.nameLabel.text         = "\(player.fullName), \(player.age) years"
        self.priceLabel.text        = "PRICE: \(player.soccerPrice)"
        self.teamNameLabel.text     = "TEAM: \(player.team.nameTeam)"
        self.photoImageView.image   = UIImage(named: player.photoName)
        self.flagImageView.image    = UIImage(named: player.countryName)
        self.teamImageView.image    = UIImage(named: player.team.imageTeam)
    }
}
