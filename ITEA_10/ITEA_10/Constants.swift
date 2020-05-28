//
//  Constants.swift
//  ITEA_10
//
//  Created by Oleksandr Kurtsev on 25/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

// Keys

let signInSegue = "signInSegue"

// Validation

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

func alertCreation(with title: String, message: String) -> UIAlertController {
    let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Хорошо", style: .default)
    alert.addAction(action)
    return alert
}
