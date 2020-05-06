//
//  ViewController.swift
//  ITEA_03
//
//  Created by Oleksandr Kurtsev on 07/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    let backgroundImageView = UIImageView()
    var studentsArray = [Student]()
    
    //MARK: - Init
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        
        myTextField.delegate = self
        self.studentsArray = createdStudents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Notification
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    //MARK: - Methods
    
    func createdStudents() -> [Student] {
        
        let student1 = Student(name: "Alex", surname: "Kurtsev", email: "kurtsev0103@gmail.com", age: 26, phone: 48661999590, photo: UIImage(named: "face1")!)
        let student2 = Student(name: "Julia", surname: "Ostapenko", email: "julia25@gmail.com", age: 25, phone: 48545764997, photo: UIImage(named: "face4")!)
        let student3 = Student(name: "Margo", surname: "Ivleeva", email: "ivleeva@gmail.com", age: 29, phone: 48890665334, photo: UIImage(named: "face3")!)
        let student4 = Student(name: "Dima", surname: "Kovalev", email: "kovalev_dima@mail.ru", age: 32, phone: 48786543888, photo: UIImage(named: "face2")!)
        let student5 = Student(name: "Oksana", surname: "Konovalova", email: "oksik_kon@gmail.com", age: 27, phone: 48121557443, photo: UIImage(named: "face5")!)
        
        return [student1, student2, student3, student4, student5]
    }
    
    func searchStudent() -> Student? {
        for student in self.studentsArray {
            if student.name.lowercased() == self.myTextField.text?.lowercased() {
                return student
            }
        }
        return nil
    }
    
    func showStudent(student: Student?) {
        if let stud = student {
            self.nameLabel.text = stud.name + " " + stud.surname
            self.ageLabel.text = "\(stud.age) years"
            self.phoneLabel.text = String(stud.phone)
            self.emailLabel.text = stud.email
            self.myImageView.image = stud.photo
        }
    }
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "background")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    //MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Actions

    @IBAction func searchButton(_ sender: Any) {
        if let student = searchStudent() {
            showStudent(student: student)
        } else {
            
            let title = "Dont have this Student"
            var mess = "Try: "

            for stud in studentsArray {
                mess += stud.name + ", "
            }
            
            let alertController = UIAlertController.init(title: title, message: mess, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "Ok", style: .default) { (action) in
            }
            
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
    }
    
}

