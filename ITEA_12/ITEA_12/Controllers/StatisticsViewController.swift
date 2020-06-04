//
//  StatisticsViewController.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 03/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    var idTeam: Int!

    @IBOutlet weak var homeMatchesLabel: UILabel!
    @IBOutlet weak var awayMatchesLabel: UILabel!
    @IBOutlet weak var totalMatchesLabel: UILabel!
    
    @IBOutlet weak var homeWinsLabel: UILabel!
    @IBOutlet weak var awayWinsLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    
    @IBOutlet weak var homeDrawsLabel: UILabel!
    @IBOutlet weak var awayDrawsLabel: UILabel!
    @IBOutlet weak var totalDrawsLabel: UILabel!
    
    @IBOutlet weak var homeLosesLabel: UILabel!
    @IBOutlet weak var awayLosesLabel: UILabel!
    @IBOutlet weak var totalLosesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager().fetchStatisticsTeam(withTeamID: idTeam) { statistics in
            DispatchQueue.main.async {
                self.homeMatchesLabel.text = String(statistics.homeMatchs)
                self.awayMatchesLabel.text = String(statistics.awayMatchs)
                self.totalMatchesLabel.text = String(statistics.totalMatchs)
                
                self.homeWinsLabel.text = String(statistics.homeWins)
                self.awayWinsLabel.text = String(statistics.awayWins)
                self.totalWinsLabel.text = String(statistics.totalWins)
                
                self.homeDrawsLabel.text = String(statistics.homeDraws)
                self.awayDrawsLabel.text = String(statistics.awayDraws)
                self.totalDrawsLabel.text = String(statistics.totalDraws)
                
                self.homeLosesLabel.text = String(statistics.homeLoses)
                self.awayLosesLabel.text = String(statistics.awayLoses)
                self.totalLosesLabel.text = String(statistics.totalLoses)
            }
        }
    }

}
