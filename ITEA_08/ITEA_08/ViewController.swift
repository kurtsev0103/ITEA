//
//  ViewController.swift
//  ITEA_08
//
//  Created by Oleksandr Kurtsev on 18/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var nameTextField: CustomTextField!
    
    var context: NSManagedObjectContext!
    let countImages = 10
    var currentIndex = 1
    var currentImage = "team1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        teamImageView.image = UIImage(named: currentImage)
    }
    
    private func saveUser() {
        if nameTextField.text!.count != 0 {
            
            // Сохранение аккаунта по ключу в UserDefaults
            let defaults = UserDefaults.standard
            defaults.set("No", forKey:firstTimeKey)
            defaults.set(nameTextField.text, forKey: userNickKey)
            defaults.synchronize()

            // Создание моей команды
            let team = Team(context: context)
            team.name = nameTextField.text
            team.image = currentImage
            createdPlayers(for: team)

            // Создание дефолтных команд
            createdStandardTeams()
            
            // Сохранение
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            // Переход на следующий экран
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MyTeamViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    private func createdPlayers(for team: Team) {
        for _ in 0..<10 {
            let player = Player(context: context)
            player.name = names.randomElement()
            player.surname = surnames.randomElement()
            player.countryImage = country.randomElement()
            player.age = Int16(Int.random(in: 18..<40))
            player.team = team
        }
    }
    
    private func createdStandardTeams() {
        for i in 1...countImages {
            if i != currentIndex {
                let team = Team(context: context)
                team.name = teamNames[i - 1]
                team.image = "team" + String(i)
                createdPlayers(for: team)
            }
        }
    }
    
    @IBAction func previousAction(_ sender: CustomButton) {
        sender.shake()
        if currentIndex > 1 {
            currentIndex -= 1
            currentImage = "team" + String(currentIndex)
            teamImageView.image = UIImage(named: currentImage)
        }
    }
    
    @IBAction func nextAction(_ sender: CustomButton) {
        sender.shake()
        if currentIndex < countImages {
            currentIndex += 1
            currentImage = "team" + String(currentIndex)
            teamImageView.image = UIImage(named: currentImage)
        }
    }
    
    @IBAction func createAccountAction(_ sender: CustomButton) {
        sender.shake()
        nameTextField.resignFirstResponder()
        saveUser()
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveUser()
        return true
    }
}

