//
//  MainViewController.swift
//  ITEA_10
//
//  Created by Oleksandr Kurtsev on 25/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class MainViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var facebookButton: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passTextField.delegate = self
        facebookButton.delegate = self
        facebookButton.permissions = ["public_profile", "email"]
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loginTextField.text = ""
        passTextField.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func signInAction(_ sender: UIButton) {
        if isValidEmail(email: loginTextField.text) && isValidPass(pass: passTextField.text) {
            
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passTextField.text!) {
                [weak self] authResult, error in
                
                guard self != nil else { return }
                if authResult?.user != nil {
                
                self?.performSegue(withIdentifier: signInSegue, sender: nil)
                    
                } else {
                    
                    let alert = alertCreation(with: "Неправильный логин или пароль",
                                              message: "Попробуйте еще раз")
                    self?.present(alert, animated: true)

                }
            }
            
        } else {
            
            let alert = alertCreation(with: "Пожалуйста",
                                      message: "Введите корректный имейл и пароль")
            present(alert, animated: true)
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField: passTextField.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        return true
    }
}

extension MainViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        guard result!.isCancelled == false else { return }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
            window?.rootViewController?.performSegue(withIdentifier: "signInSegue", sender: nil)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Log Out")
    }
}
