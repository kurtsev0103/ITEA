//
//  ViewController.swift
//  ITEA_05_TableView
//
//  Created by Oleksandr Kurtsev on 08/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

let countMatches = 50

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    let teams = Team.createdTeams()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countMatches
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TeamCell", owner: self, options: nil)?.first as! TeamCell
        
        var random = Int.random(in: 0..<5)
        cell.firstTeamScore.text = String(random)
        random = Int.random(in: 0..<5)
        cell.secondTeamScore.text = String(random)
        
        cell.firstTeamView.image = teams.randomElement()?.imageTeam
        cell.secondTeamView.image = teams.randomElement()?.imageTeam
        
        return cell
    }
    
    //MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

}

