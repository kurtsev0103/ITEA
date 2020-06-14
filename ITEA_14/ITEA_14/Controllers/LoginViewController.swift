//
//  AppDelegate.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: CustomTextField!
    @IBOutlet weak var passwordTF: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: CustomBatton) {
        AuthManager.shared.login(email: emailTF.text, password: passwordTF.text) { (result) in
            switch result {
            case .success(_):
                self.showAlert(with: "Success", and: "You are authorized") {
                    let vc = self.storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: CustomBatton) {
        dismiss(animated: true)
    }
}
