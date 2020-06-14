//
//  AppDelegate.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func accountAction(_ sender: UIButton) {
        showActionSheet() {
            do {
                try Auth.auth().signOut()
                self.goToAuthViewController()
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }
    
    private func goToAuthViewController() {
        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        if window?.rootViewController is AuthViewController {
            dismiss(animated: true)
        } else {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "AuthViewController")
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            UIView.transition(with: window!, duration: 0.5, options: .transitionFlipFromLeft, animations: {})
        }
    }
}
