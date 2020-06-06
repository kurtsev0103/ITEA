//
//  MainViewController.swift
//  ITEA_13
//
//  Created by Oleksandr Kurtsev on 06/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            self.photoImageView.layer.masksToBounds = false
            self.photoImageView.layer.borderColor = UIColor.black.cgColor
            self.photoImageView.layer.cornerRadius = self.photoImageView.frame.height / 2
            self.photoImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultParams()
        activityIndicator.startAnimating()
        refreshButton.isHidden = true
        addAllParams()
    }
    
    private func defaultParams() {
        photoImageView.image = nil
        fullNameLabel.text = ""
        emailLabel.text = ""
        titleLabel.text = ""
        jobLabel.text = ""
        adressLabel.text = ""
        phoneLabel.text = ""
    }
    
    private func addAllParams() {
        NetworkManager.shared.fetchJSONData { (user) in
            DispatchQueue.main.async {
                
                NetworkManager.shared.fetchImage(with: user.photo) { (data) in
                    self.photoImageView.image = UIImage(data: data)
                }
                
                self.fullNameLabel.text = user.lastName + " " + user.firstName
                self.emailLabel.text = user.email
                self.titleLabel.text = user.title
                self.jobLabel.text = user.jobType
                let adress = user.address.zipCode + ", " +
                             user.address.country + ", " +
                             user.address.city + ", " +
                             user.address.street
                self.adressLabel.text = adress
                
                var str = ""
                for (index, phone) in user.telephone.enumerated() {
                    str += phone
                    if index < user.telephone.count - 1 {
                        str += "\n"
                    }
                }
                self.phoneLabel.text = str
                self.refreshButton.isHidden = false
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
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
    @IBAction func refreshAction(_ sender: UIButton) {
        defaultParams()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        refreshButton.isHidden = true
        addAllParams()
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
