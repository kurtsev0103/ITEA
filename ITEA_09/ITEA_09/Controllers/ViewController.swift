//
//  ViewController.swift
//  ITEA_09
//
//  Created by Oleksandr Kurtsev on 21/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loginTextField.text = ""
        passTextField.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: loginTextField.text)
    }
    
    private func isValidPass() -> Bool {
        guard let pass = passTextField.text else { return false }
        return pass.count > 5
    }

    @IBAction func signInAction(_ sender: UIButton) {
        if isValidEmail() && isValidPass() {
            
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passTextField.text!) {
                [weak self] authResult, error in
                
                guard self != nil else { return }
                if authResult?.user != nil {
                
                let defaults = UserDefaults.standard
                defaults.set(true, forKey:isAuthorizedKey)
                defaults.synchronize()
                
                self?.performSegue(withIdentifier: signInSegue, sender: nil)
                    
                } else {
                    let alert = UIAlertController.init(title: "Неправильный логин или пароль", message: "Попробуйте еще раз", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Хорошо", style: .default)
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                }
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
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField: passTextField.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        return true
    }
}
