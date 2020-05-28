//
//  CreateAccountViewController.swift
//  ITEA_10
//
//  Created by Oleksandr Kurtsev on 25/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var passTwoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTextField.delegate = self
        passTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func registrationAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if isValidEmail(email: mailTextField.text) && isValidPass(pass: passTextField.text) && passTextField.text == passTwoTextField.text {
            
            Auth.auth().createUser(withEmail: mailTextField.text!, password: passTextField.text!) { authResult, error in
              
                let alert = UIAlertController.init(title: "Поздравляем",
                                                   message: "Теперь вы можете войти в свой аккаунт Fakebook",
                                                   preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Хорошо", style: .default) { _ in
                    self.dismiss(animated: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
                
            }
            
        } else {
            
            let alert = alertCreation(with: "Пожалуйста",
                                      message: "Введите корректный имейл и пароль")
            present(alert, animated: true)
            
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case mailTextField: passTextField.becomeFirstResponder()
        case passTextField: passTwoTextField.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        return true
    }
}
