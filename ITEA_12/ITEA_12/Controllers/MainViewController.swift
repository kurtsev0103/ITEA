//
//  MainViewController.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 02/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var networkManager = NetworkManager()
    var teams = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamsTableViewCell.nib(), forCellReuseIdentifier: TeamsTableViewCell.identifier)
        fetchData()
    }
    
    func fetchData() {
        networkManager.fetchCurrentTeams() { teams in
            self.teams = teams
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch {
            print (error.localizedDescription)
        }
        
        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        if window?.rootViewController is LoginViewController {
            dismiss(animated: true)
        } else {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            UIView.transition(with: window!, duration: 0.5, options: .transitionFlipFromLeft, animations: {})
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamsTableViewCell.identifier, for: indexPath) as! TeamsTableViewCell
                        
        cell.configure(withTeam: teams[indexPath.row])
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        cell.logoImageView.addGestureRecognizer(recognizer)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "TeamInfoViewController") as! TeamInfoViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.team = teams[indexPath.row]
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "StatisticsViewController") as! StatisticsViewController
        vc.idTeam = teams[indexPath.row].teamID
        present(vc, animated: true)
    }
}

extension MainViewController {
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .systemGray4
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
