//
//  TeamInfoViewController.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 04/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class TeamInfoViewController: UIViewController {

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamCountryLabel: UILabel!
    @IBOutlet weak var teamFoundedLabel: UILabel!
    
    var team: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamNameLabel.text = team.teamName
        teamCountryLabel.text = team.teamCountry
        teamFoundedLabel.text = String(team.teamFounded)
        
        NetworkManager().downloadImage(withURL: team.teamLogo) { image in
            self.teamImageView.image = image
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
