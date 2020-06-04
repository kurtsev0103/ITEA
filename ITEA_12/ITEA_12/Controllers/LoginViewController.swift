//
//  LoginViewController.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 02/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTF: LoginTextField!
    @IBOutlet weak var passwordTF: LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTF.delegate = self
        passwordTF.delegate = self
        addNotificationsKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loginTF.text = ""
        passwordTF.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func addNotificationsKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func loginAction(_ sender: LoginButton) {
        if isValidEmail(email: loginTF.text) && isValidPass(pass: passwordTF.text) {
            Auth.auth().signIn(withEmail: loginTF.text!, password: passwordTF.text!) {
                [weak self] authResult, error in
                guard let strongSelf = self else { return }
                
                if authResult?.user != nil {
                    strongSelf.performSegue(withIdentifier: signInSegue, sender: nil)
                } else {
                    strongSelf.present(showAlert(), animated: true)
                }
            }
        } else {
            present(showAlert(), animated: true)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTF: passwordTF.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        return true
    }
}

extension LoginViewController {
    
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
