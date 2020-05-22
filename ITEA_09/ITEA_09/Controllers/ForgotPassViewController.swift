//
//  ForgotPassViewController.swift
//  ITEA_09
//
//  Created by Oleksandr Kurtsev on 22/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class ForgotPassViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: mailTextField.text)
    }

    @IBAction func sendLetterAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if isValidEmail() {
            
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
            let alert = UIAlertController.init(title: "Неправильно введен имейл",
                                               message: "Попробуйте еще раз",
                                               preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Хорошо", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
