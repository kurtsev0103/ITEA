//
//  SecondViewController.swift
//  ITEA_11
//
//  Created by Oleksandr Kurtsev on 02/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllParams()
    }
    
    private func addAllParams() {
        nameLabel.text = ""
        emailLabel.text = ""
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func updateInterface(with user: CurrentUser) {
        DispatchQueue.main.async {
            self.nameLabel.text = user.fullName
            self.emailLabel.text = user.email
            self.fetchImage(with: user.photo)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    private func fetchImage(with urlString: String) {
        let imageURL = URL(string: urlString)
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
        photoImageView.image = UIImage(data: imageData)
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.masksToBounds = false
        photoImageView.layer.borderColor = UIColor.black.cgColor
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        photoImageView.clipsToBounds = true
    }
}
