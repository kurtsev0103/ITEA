//
//  ForgotPassViewController.swift
//  ITEA_10
//
//  Created by Oleksandr Kurtsev on 25/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class ForgotPassViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func sendLetterAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if isValidEmail(email: mailTextField.text) {
            
            Auth.auth().sendPasswordReset(withEmail: mailTextField.text!) { error in
                let alert = UIAlertController.init(title: "Письмо отправлено",
                                                   message: "Проверьте свою электронную почту",
                                                   preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Спасибо", style: .default) { _ in
                    self.dismiss(animated: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            
        } else {
            
            let alert = alertCreation(with: "Неправильно введен имейл",
                                      message: "Попробуйте еще раз")
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension ForgotPassViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
