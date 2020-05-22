//
//  SuccessViewController.swift
//  ITEA_09
//
//  Created by Oleksandr Kurtsev on 22/05/2020.
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
        try! Auth.auth().signOut()

        let defaults = UserDefaults.standard
        defaults.set(false, forKey:isAuthorizedKey)
        defaults.synchronize()
  
        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        
        if window?.rootViewController is ViewController {
            
            dismiss(animated: true)
            
        } else {

            let vc = self.storyboard!.instantiateViewController(withIdentifier: "ViewController")
 
            window?.rootViewController = vc
            UIView.transition(with: window!, duration: 0.5, options: .transitionFlipFromRight, animations: {})
        }
        
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        print("dismiss SuccessViewController")
    }
    
}
