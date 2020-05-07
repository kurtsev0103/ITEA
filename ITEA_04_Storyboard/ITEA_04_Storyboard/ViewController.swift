//
//  ViewController.swift
//  ITEA_04_Storyboard
//
//  Created by Oleksandr Kurtsev on 07/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var studentsArray = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.studentsArray = Student.createdStudents().sorted(by: {$0.fullName < $1.fullName})
    }

    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = self.studentsArray[indexPath.row].fullName
        cell.detailTextLabel?.text = String(self.studentsArray[indexPath.row].phone)
        cell.imageView?.image = studentsArray[indexPath.row].photo
        
        return cell
    }

}

