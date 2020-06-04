//
//  RegistrationViewController.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 03/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var passTwoTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTF.delegate = self
        passTF.delegate = self
        passTwoTF.delegate = self
        addNotificationsKeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func addNotificationsKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(RegistrationViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegistrationViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func registrationAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if isValidEmail(email: mailTF.text) && isValidPass(pass: passTF.text) && passTF.text == passTwoTF.text {
            
            Auth.auth().createUser(withEmail: mailTF.text!, password: passTF.text!) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                let alert = UIAlertController.init(title: "Congratulations",
                                                   message: "You can now log in to your account",
                                                   preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Ok", style: .default) { _ in
                    self.dismiss(animated: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        } else {
            present(showAlert(), animated: true)
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case mailTF: passTF.becomeFirstResponder()
        case passTF: passTwoTF.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        return true
    }
}

extension RegistrationViewController {
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
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
    
}
