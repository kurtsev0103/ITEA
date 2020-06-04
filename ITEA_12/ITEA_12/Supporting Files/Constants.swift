//
//  Constants.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 02/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

// Constants

let apiKey = "7102c46b9amshdcbc49f650a47c1p1f3d42jsnac61983b0e7f"
let signInSegue = "signInSegue"

// Colors & Fonts

struct Colors {
    static let tropicBlue = UIColor(red: 0, green: 192/255, blue: 255/255, alpha: 1)
}

struct Fonts {
    static let avenirNextCondensedDemiBold = "AvenirNextCondensed-DemiBold"
}

// Validations

func isValidEmail(email: String?) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func isValidPass(pass: String?) -> Bool {
    guard let p = pass else { return false }
    return p.count > 5
}

// Alert

func showAlert() -> UIAlertController {
    let alert = UIAlertController.init(title: "Wrong data", message: "Please try again", preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default)
    alert.addAction(action)
    return alert
}
