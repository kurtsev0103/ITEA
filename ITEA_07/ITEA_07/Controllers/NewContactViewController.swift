//
//  NewContactViewController.swift
//  ITEA_07
//
//  Created by Oleksandr Kurtsev on 15/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import CoreData

protocol AddContactDelegate {
    func addContact(contact: NSManagedObject)
}

class NewContactViewController: UIViewController {
    
    var delegate: AddContactDelegate?
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextFieldsDelegate()
        addAllParams()
        nameTextField.becomeFirstResponder()
    }
    
    func addAllParams() {
        imageView.image = UIImage(named: "man")
    }
    
    func addTextFieldsDelegate() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        phoneTextField.delegate = self
        adressTextField.delegate = self
        emailTextField.delegate = self
    }
    
    //MARK: - Actions
    
    @IBAction func manOrWomanAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            imageView.image = UIImage(named: "man")
        } else {
            imageView.image = UIImage(named: "woman")
        }
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context) else { return }
        let contactObj = Contact(entity: entity, insertInto: context)
        
        contactObj.name = nameTextField.text
        contactObj.surname = surnameTextField.text
        contactObj.phone = phoneTextField.text
        contactObj.adress = adressTextField.text
        contactObj.email = emailTextField.text
        contactObj.gender = genderSegmentedControl.selectedSegmentIndex == 0 ? true : false
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.delegate?.addContact(contact: contactObj)
        navigationController?.popViewController(animated: true)
    }
}

extension NewContactViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField: surnameTextField.becomeFirstResponder()
        case surnameTextField: phoneTextField.becomeFirstResponder()
        case phoneTextField: adressTextField.becomeFirstResponder()
        case adressTextField: emailTextField.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        return true
    }
}
