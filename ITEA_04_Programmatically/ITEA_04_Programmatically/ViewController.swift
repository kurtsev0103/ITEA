//
//  ViewController.swift
//  ITEA_04_Programmatically
//
//  Created by Oleksandr Kurtsev on 07/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    var studentsArray = [Student]()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .darkGray
        tableView.backgroundColor = .darkGray
        safeArea = view.layoutMarginsGuide
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setupTableView()
                
        self.studentsArray = Student.createdStudents().sorted(by: {$0.fullName < $1.fullName})
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.studentsArray[indexPath.row].fullName
        cell.imageView?.image = studentsArray[indexPath.row].photo
        
        let label = UILabel.init(frame: CGRect(x:0,y:0,width:140,height:20))
        label.text = String(self.studentsArray[indexPath.row].phone)
        cell.accessoryView = label
        
        cell.backgroundColor = .darkGray
        cell.textLabel?.textColor = .white
        label.textColor = .white
        
        return cell
    }

}
