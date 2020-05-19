//
//  MyTeamViewController.swift
//  ITEA_08
//
//  Created by Oleksandr Kurtsev on 18/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import CoreData

class MyTeamViewController: UIViewController {

    @IBOutlet weak var myTeamImageView: UIImageView!
    @IBOutlet weak var myTeamNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myLevelLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var myTeam: Team!
    var myMatches = [Match]()
    var players = [Player]()
    var teams: [Team]!
    
    // Lazy context
    lazy var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerTableViewCell.nib(), forCellReuseIdentifier: PlayerTableViewCell.identifier)
        tableView.register(TeamTableViewCell.nib(), forCellReuseIdentifier: TeamTableViewCell.identifier)
        tableView.register(MatchTableViewCell.nib(), forCellReuseIdentifier: MatchTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Запрос на получение всех команд
        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
           
        // Получение команд
        do {
            teams = try context?.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        // Получение никнейма из UserDefaults
        let nick = UserDefaults.standard.string(forKey: userNickKey)
        
        // Поиск моей команды по никнейму
        for (index, team) in teams.enumerated() {
            if team.name == nick {
                
                // Установка моей команды
                myTeam = team
                myTeamNameLabel.text = myTeam.name
                myTeamImageView.image = UIImage(named: myTeam.image!)
                myLevelLabel.text = "WINS: " + String(myTeam.wins)
                
                // Установка моих игроков
                players = (myTeam.players?.allObjects as! [Player]).sorted(by: {$0.name! < $1.name!})
                
                // Проверка на наличие матчей и установка если они есть
                if let mMatches = myTeam.value(forKey: "matches") {
                    let array = (mMatches as! Matches).matches
                    myMatches = array.sorted(by: {$0.timeMatch > $1.timeMatch})
                }
                
                // Удаление моей команды из списка всех команд
                teams.remove(at: index)
            }
        }
    }
    
    @IBAction func playAction(_ sender: CustomButton) {
        sender.shake()
        
        let winStr = "Congratulations! You won"
        let lostStr = "Sorry :( But you lost"
        let drawStr = "Hmm... In this match, a draw"
        var string = ""
        
        let a = Int.random(in: 0..<5)
        let b = Int.random(in: 0..<5)
        let randomeHomePlayer = Int.random(in: 0...1)
        
        // Создание нового матча
        let enemyTeam = teams.randomElement()!
        var match = Match()
        
        if randomeHomePlayer == 0 {
            match = Match(firstTeamName: myTeam.name!, secondTeamName: enemyTeam.name!, firstTeamGoals: a, seconTeamGols: b, timeMatch: Date())
        } else {
            match = Match(firstTeamName: enemyTeam.name!, secondTeamName: myTeam.name!, firstTeamGoals: a, seconTeamGols: b, timeMatch: Date())
        }
        
        // Получение всех предыдущих матчей (Optional?)
        let mMatches = myTeam.value(forKey: "matches") as? Matches
        
        // Проверка на наличие предыдущих матчей и добавление его моей команде
        if var array = mMatches?.matches {
            array.append(match)
            let matches = Matches.init(matches: array)
            myTeam.setValue(matches, forKey: "matches")
        } else {
            let matches = Matches.init(matches: [match])
            myTeam.setValue(matches, forKey: "matches")
        }

        // Обновление таблицы
        myMatches.insert(match, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        
        // Выбор нужной строки в алерт и обновление счетчика побед
        switch randomeHomePlayer {
        case 0 where a > b:  string = winStr; myTeam.wins += 1
        case 1 where a < b:  string = winStr; myTeam.wins += 1
        case 0 where a < b:  string = lostStr
        case 1 where a > b:  string = lostStr
        case _ where a == b: string = drawStr
        default: break
        }
        
        myLevelLabel.text = "WINS: " + String(myTeam.wins)

        // Сохранение
        do {
            try context?.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        // Создание уведомления (выигрыш, проигрыш или ничья)
        let alertController = UIAlertController.init(title: string, message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .default) { (action) in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}

extension MyTeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return players.count
        } else if segmentControl.selectedSegmentIndex == 1 {
            return myMatches.count
        } else {
            return teams.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentControl.selectedSegmentIndex == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as! PlayerTableViewCell
            cell.configure(with: players[indexPath.row])
            return cell
            
        } else if segmentControl.selectedSegmentIndex == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as! MatchTableViewCell
            cell.configure(with: myMatches[indexPath.row])
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier, for: indexPath) as! TeamTableViewCell
            cell.configure(with: teams[indexPath.row])
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 5
    }
}
