//
//  AppDelegate.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTF: CustomTextField!
    @IBOutlet weak var passwordTF: CustomTextField!
    @IBOutlet weak var confirmPasswordTF: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpAction(_ sender: CustomBatton) {
        AuthManager.shared.register(email: emailTF.text, password: passwordTF.text, confirmPassword: confirmPasswordTF.text) { (result) in
            switch result {
            case .success(let user):
                self.showAlert(with: "Success", and: "Are you registered") {
                    let vc = self.storyboard?.instantiateViewController(identifier: "SetupProfileViewController") as! SetupProfileViewController
                    vc.modalTransitionStyle = .flipHorizontal
                    vc.modalPresentationStyle = .fullScreen
                    vc.currentUser = user
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
