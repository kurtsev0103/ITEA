//
//  SuccessViewController.swift
//  ITEA_10
//
//  Created by Oleksandr Kurtsev on 25/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class SuccessViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
            
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = Auth.auth().currentUser {
            self.user = user
            welcomeLabel.text = user.email
        }
    }

    @IBAction func logoutAction(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print (signOutError.localizedDescription)
        }

        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        
        if window?.rootViewController is MainViewController {
            
            dismiss(animated: true)
            
        } else {

            let vc = self.storyboard!.instantiateViewController(withIdentifier: "MainViewController")
 
            window?.rootViewController = vc
            UIView.transition(with: window!, duration: 0.5, options: .transitionFlipFromRight, animations: {})
        }
        
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        //print("dismiss SuccessViewController")
    }
    
}
