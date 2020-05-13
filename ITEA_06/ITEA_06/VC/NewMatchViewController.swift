//
//  NewMatchViewController.swift
//  ITEA_06
//
//  Created by Oleksandr Kurtsev on 13/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class NewMatchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerTeams: UIPickerView!
    @IBOutlet weak var firstTeamImageView: UIImageView!
    @IBOutlet weak var secondTeamImageView: UIImageView!
    @IBOutlet weak var firstTeamNameLabel: UILabel!
    @IBOutlet weak var secondTeamNameLabel: UILabel!
    
    var rootVC: ViewController!
    
    var selectedFirstTeam = teams[0]
    var selectedSecondTeam = teams[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllParams()
        
        pickerTeams.delegate = self
        pickerTeams.dataSource = self
    }
    
    func addAllParams() {
        self.firstTeamNameLabel.text = teams[0].nameTeam
        self.secondTeamNameLabel.text = teams[0].nameTeam
        self.firstTeamImageView.image = UIImage(named: teams[0].imageTeam)
        self.secondTeamImageView.image = UIImage(named: teams[0].imageTeam)
    }
    
    //MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teams.count
    }
    
    //MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teams[row].nameTeam
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedFirstTeam = teams[row]
            
            self.firstTeamNameLabel.text = selectedFirstTeam.nameTeam
            self.firstTeamImageView.image = UIImage(named: selectedFirstTeam.imageTeam)
            
        } else {
            selectedSecondTeam = teams[row]
            
            self.secondTeamNameLabel.text = selectedSecondTeam.nameTeam
            self.secondTeamImageView.image = UIImage(named: selectedSecondTeam.imageTeam)

        }
    }
    
    //MARK: Action
    
    @IBAction func playMatch(_ sender: UIButton) {
        
        if selectedFirstTeam.nameTeam == selectedSecondTeam.nameTeam {
            
            let title = "You cannot select the same commands"
            let mess = "Please try again"

            let alertController = UIAlertController.init(title: title, message: mess, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "Ok", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
            
        } else {
            
            let match = Match.playMatch(firstTeam: selectedFirstTeam, secondTeam: selectedSecondTeam)
            
            matches.insert(match!, at: 0)
            dismiss(animated: true)
            rootVC.tableView.reloadData()            
        }
    }
    
}
