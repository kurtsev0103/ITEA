//
//  ViewController.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 11/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var matches = [Match]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MatchTableViewCell.nib(), forCellReuseIdentifier: MatchTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
                
        playMatches(count: 5)
    }

    func playMatches(count: Int) {
        for _ in 0..<count {
            if let match = Match.playMatch(firstTeam: teams.randomElement()!, secondTeam: teams.randomElement()!) {
                matches.append(match)
            }
        }
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as! MatchTableViewCell
        
        cell.configure(with: matches[indexPath.row])
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let infoVC = storyboard.instantiateViewController(identifier: "InfoMatchViewController") as! InfoMatchViewController
        infoVC.match = matches[indexPath.row]
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    //MARK: - Actions
    
    @IBAction func addNewMatch(_ sender: Any) {
        if let match = Match.playMatch(firstTeam: teams.randomElement()!, secondTeam: teams.randomElement()!) {
            matches.append(match)
        } else {
            addNewMatch(self)
        }
        tableView.reloadData()
    }
    
}

