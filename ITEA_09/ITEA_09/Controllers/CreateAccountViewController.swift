//
//  CreateAccountViewController.swift
//  ITEA_09
//
//  Created by Oleksandr Kurtsev on 22/05/2020.
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
    
    private func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: mailTextField.text)
    }
    
    private func isValidPass() -> Bool {
        guard passTextField.text == passTwoTextField.text else { return false }
        guard let pass = passTextField.text else { return false }
        return pass.count > 5
    }
    
    @IBAction func registrationAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if isValidEmail() && isValidPass() {
            
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
            
            let alert = UIAlertController.init(title: "Пожалуйста",
                                               message: "Введите корректный имейл и пароль",
                                               preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Хорошо", style: .default)
            alert.addAction(action)
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
