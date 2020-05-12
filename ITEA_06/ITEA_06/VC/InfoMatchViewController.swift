//
//  InfoMatchViewController.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 11/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class InfoMatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var firstTeamImage: UIImageView!
    @IBOutlet weak var secondTeamImage: UIImageView!
    @IBOutlet weak var firstTeamName: UILabel!
    @IBOutlet weak var secondTeamName: UILabel!
    @IBOutlet weak var firstTeamScore: UILabel!
    @IBOutlet weak var secondTeamScore: UILabel!
    @IBOutlet weak var tableView: UITableView!
        
    var match: Match!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllParams()
        self.title = "Match"
        
        tableView.register(InfoTableViewCell.nib(), forCellReuseIdentifier: InfoTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addAllParams() {
        self.firstTeamName.text = match.firstTeam.nameTeam
        self.secondTeamName.text = match.secondTeam.nameTeam
        self.firstTeamImage.image = UIImage(named: match.firstTeam.imageTeam)
        self.secondTeamImage.image = UIImage(named: match.secondTeam.imageTeam)
        self.firstTeamScore.text = String(match.firstTeamGoals)
        self.secondTeamScore.text = String(match.secondTeamGoals)
    }

    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return match.scoredGoal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
              
        cell.configure(player: match.scoredGoal[indexPath.row],
                       firstTeam: match.firstTeam,
                       secondTeam: match.secondTeam)
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let playerVC = storyboard.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        playerVC.player = match.scoredGoal[indexPath.row]
        self.navigationController?.pushViewController(playerVC, animated: true)
    }

}
