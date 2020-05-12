//
//  InfoTeamViewController.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 12/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class InfoTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchPlayersToMatches: UISegmentedControl!
    
    var team: Team!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = team.nameTeam
        addAllParams()
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(MatchesForTeamTableViewCell.nib(), forCellReuseIdentifier: MatchesForTeamTableViewCell.identifier)
        tableView.register(PlayerForTeamTableViewCell.nib(), forCellReuseIdentifier: PlayerForTeamTableViewCell.identifier)
    }

    func addAllParams() {
        self.teamImageView.image = UIImage(named: team.imageTeam)
        self.nameTeam.text = team.nameTeam
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if switchPlayersToMatches.selectedSegmentIndex == 0 {
            return team.players.count
        } else {
            return team.matches.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if switchPlayersToMatches.selectedSegmentIndex == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayerForTeamTableViewCell.identifier, for: indexPath) as! PlayerForTeamTableViewCell
            cell.configure(player: team.players[indexPath.row])
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MatchesForTeamTableViewCell.identifier, for: indexPath) as! MatchesForTeamTableViewCell
            cell.configure(match: team.matches[indexPath.row])
            return cell
            
        }
    }
    
    //MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return tableView.frame.height / 6
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            if switchPlayersToMatches.selectedSegmentIndex == 0 {
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                let playerVC = storyboard.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
                playerVC.player = team.players[indexPath.row]
                self.navigationController?.pushViewController(playerVC, animated: true)
                
            } else {
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                let matchVC = storyboard.instantiateViewController(identifier: "InfoMatchViewController") as! InfoMatchViewController
                matchVC.match = team.matches[indexPath.row]
                self.navigationController?.pushViewController(matchVC, animated: true)
                
            }
        }
    
    //MARK: - UISegmentedControl
    
    @IBAction func switchPlayersToMatches(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
}
