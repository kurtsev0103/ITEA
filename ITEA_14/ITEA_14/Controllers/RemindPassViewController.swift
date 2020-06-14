//
//  AppDelegate.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class RemindPassViewController: UIViewController {

    @IBOutlet weak var emailTF: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendEmailAction(_ sender: CustomBatton) {
        AuthManager.shared.remindPassword(email: emailTF.text) { (result) in
            switch result {
            case .success(_):
                self.showAlert(with: "Congratulations", and: "Check your email") {
                    self.dismiss(animated: true)
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
