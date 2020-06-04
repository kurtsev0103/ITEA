//
//  RestorePassViewController.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 03/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class RestorePassViewController: UIViewController {

    @IBOutlet weak var mailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTF.delegate = self
        addNotificationsKeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func addNotificationsKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(RestorePassViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RestorePassViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func sendLetterAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if isValidEmail(email: mailTF.text) {
            
            Auth.auth().sendPasswordReset(withEmail: mailTF.text!) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                let alert = UIAlertController.init(title: "Email sent",
                                                   message: "Check your email",
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

extension RestorePassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RestorePassViewController {
    
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
