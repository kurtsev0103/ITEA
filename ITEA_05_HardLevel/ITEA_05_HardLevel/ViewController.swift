//
//  ViewController.swift
//  ITEA_05_HardLevel
//
//  Created by Oleksandr Kurtsev on 09/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var models = [Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.Subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        
        switch indexPath.row {
        case 0:
            models = Model.createdModels(subjects: .Food)
        case 1:
            models = Model.createdModels(subjects: .Girl)
        case 2:
            models = Model.createdModels(subjects: .Logo)
        case 3:
            models = Model.createdModels(subjects: .ThreeD)
        default:
            break
        }
        
        cell.configure(with: models)
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }

}

struct Model {
    
    static let count3d = 9
    static let countFood = 12
    static let countGirl = 13
    static let countLogo = 13
    
    enum Subjects: Int {
        case ThreeD
        case Food
        case Girl
        case Logo
        
        static let count = 4
    }
    
    let imageName: String
    
    static func createdModels(subjects: Subjects) -> [Model] {
        
        var array = [Model]()
        
        switch subjects {
            
        case .Food:
            for i in 0..<countFood {
                let str = "food" + String(i)
                let model = Model(imageName: str)
                array.append(model)
            }
        case .Girl:
            for i in 0..<countGirl {
                let str = "girl" + String(i)
                let model = Model(imageName: str)
                array.append(model)
            }
        case .Logo:
            for i in 0..<countLogo {
                let str = "logo" + String(i)
                let model = Model(imageName: str)
                array.append(model)
            }
        case .ThreeD:
            for i in 0..<count3d {
                let str = "other" + String(i)
                let model = Model(imageName: str)
                array.append(model)
            }
        }
        return array
    }
    
}

