//
//  SetupProfileViewController.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 13/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class SetupProfileViewController: UIViewController {

    @IBOutlet weak var nameTF: CustomTextField!
    @IBOutlet weak var addressTF: CustomTextField!
    @IBOutlet weak var heightTF: CustomTextField!
    @IBOutlet weak var phoneTF: CustomTextField!
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveAction(_ sender: CustomBatton) {
        FirestoreManager.shared.savePrifileWith(id: currentUser.uid, name: nameTF.text, photoString: "nil", bornDate: "Date", height: heightTF.text, address: addressTF.text, phone: phoneTF.text) { (result) in
            
            switch result {
                
            case .success(_):
                self.showAlert(with: "Success", and: "Welcome") {
                    let vc = self.storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
                    vc.modalTransitionStyle = .flipHorizontal
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
                
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
}
