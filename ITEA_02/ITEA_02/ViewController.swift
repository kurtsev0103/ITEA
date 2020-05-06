//
//  ViewController.swift
//  ITEA_02
//
//  Created by Oleksandr Kurtsev on 25/04/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var myTableView = UITableView()
    let indentifire = "MyCell"
    
    var phoneBook = [Int: String]()
    var studentsArray = [String]()
    var namesSet = Set<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Array

        studentsArray = ["Julia", "Dima", "Igor", "Boris", "Alex", "Endy"]

        func returnRandomStudent(array: [String]) -> (index: Int, name: String)? {
            if !studentsArray.isEmpty {
                let i = Int.random(in: 0..<studentsArray.count)
                let s = studentsArray[i]
                return (i, s)
            }
            return nil
        }

        func addNewStudent(name: String) {
            studentsArray.append(name)
        }

        func removeRandomStudent() {
            let s = returnRandomStudent(array: studentsArray)
            if let student = s {
                studentsArray.remove(at: student.index)
            }
        }

        func findStudent(name: String) {
            var isFound = false

            for student in studentsArray {
                if student == name {
                    isFound = true
                }
            }
            print(isFound ? "I know who is \(name)" : "I dont know who is \(name)")
        }

        func printRandomStudent() {
            let s = returnRandomStudent(array: studentsArray)
            print(s ?? "0 students!")
        }

        func filterArray() {
            let filterArray = studentsArray.filter({$0.count > 4})
            print("Filtered array - \(filterArray)")
        }

        func sortingArray() {
            print("Without sorting - \(studentsArray)")
            let sortedArray = studentsArray.sorted(by: {$0 < $1})
            print("With sorting - \(sortedArray)")
        }

        addNewStudent(name: "Oksana")           //Add element
        removeRandomStudent()                   //Remove element
        findStudent(name: "Petya")              //Find element
        print(studentsArray)                    //Print all elements
        printRandomStudent()                    //Print one element by index
        print(studentsArray.count)              //Print count of students
        filterArray()                           //Filtr
        sortingArray()                          //Sort

        //MARK: - Dictionary

        func createList(lastName: String) {
            var number = "38050"
            for _ in 0...6 {
                number += String(arc4random_uniform(10))
            }
            phoneBook.updateValue(lastName, forKey: Int(number)!)
        }

        createList(lastName: "Ivanov")
        createList(lastName: "Petrov")
        createList(lastName: "Sidorov")
        createList(lastName: "Lobanov")
        createList(lastName: "Kurtsev")

        func returnRandomPeople(dict: [Int: String]) -> Int? {
            if !dict.isEmpty {
                return phoneBook.randomElement()!.key
            }
            return nil
        }

        func removeRandomPeople() {
            let key = returnRandomPeople(dict: phoneBook)
            if let k = key {
                phoneBook.removeValue(forKey: k)
            }
        }

        func changeRandomPeople() {
            let key = returnRandomPeople(dict: phoneBook)
            if let k = key {
                phoneBook.updateValue("Prokopenko", forKey: k)
            }
        }
        
        func findPeopleForNumber(number: Int) {
            var isFound = false

            for people in phoneBook {
                if people.key == number {
                    isFound = true
                }
            }
            print(isFound ? "I know this number" : "I dont know this number")
        }

        func findPeopleForSurame(name: String) {
            var isFound = false

            for people in phoneBook {
                if people.value == name {
                    isFound = true
                }
            }
            print(isFound ? "I know this Surname" : "I dont know this Surname")
        }
        
        phoneBook[380661234490] = "Kadurin"             //Add element
        removeRandomPeople()                            //Remove element
        changeRandomPeople()                            //Change element
        findPeopleForNumber(number: 380664523778)       //Find element  (for key)
        findPeopleForSurame(name: "Alex")               //Find element  (for value)
        print(phoneBook.count)                          //Print count of pairs
        print(phoneBook.keys)                           //Print all keys
        print(phoneBook.values)                         //Print all values

        //MARK: - SET
        
        func findElementInSet(str: String) {
            if namesSet.contains(str) {
                print("I know who is \(str)")
            } else {
                print("I dont know who is \(str)")
            }
        }
        
        func sortSet(set: Set<String>, index: Int) {
            let arraySet = set.sorted()
            print(arraySet[index])
        }
        
        func filterSet(set: Set<String>) {
            let arraySet = set.filter({$0.count == 4})
            print(arraySet)
        }

        namesSet = ["Julia", "Dima", "Igor", "Boris", "Alex", "Endy"]
                
        namesSet.insert("Evgen")                        //Add element
        namesSet.remove("Dima")                         //Remove element
        findElementInSet(str: "Julia")                  //Find element
        print(namesSet)                                 //Print all elements
        sortSet(set: namesSet, index: 0)                //Print one element by index :)
        print(namesSet.count)                           //Print count
        filterSet(set: namesSet)                        //Filtr
        print(namesSet.sorted())                        //Sort
        
        //MARK: - Table View
        createTable()

    }
    
    func createTable() {
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: indentifire)
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(myTableView)
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Students (ARRAY)"
        case 1:
            return "Phonebook (DICTIONARY)"
        case 2:
            return "Names (SET)"
        default:
            break
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return studentsArray.count
        case 1:
            return phoneBook.keys.count
        case 2:
            return namesSet.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifire, for: indexPath)
        
        let allKeys = Array(phoneBook.keys)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = studentsArray[indexPath.row]
            cell.backgroundColor = UIColor.lightGray
            cell.textLabel?.textColor = UIColor.darkGray
        case 1:
            cell.textLabel?.text = "\(phoneBook[allKeys[indexPath.row]]!) , \(String(allKeys[indexPath.row]))"
            cell.backgroundColor = UIColor.lightGray
            cell.textLabel?.textColor = UIColor.darkGray
        case 2:
            cell.textLabel?.text = namesSet.sorted()[indexPath.row]
            cell.backgroundColor = UIColor.lightGray
            cell.textLabel?.textColor = UIColor.darkGray
        default:
            break
        }
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

}
