//
//  AppDelegate.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

class Validators {
    
    static func isFilled(_ email: String?, _ password: String?, _ confirmPassword: String?) -> Bool {
        guard let email = email,
            let password = password,
            let confirmPassword = confirmPassword,
            password != "",
            confirmPassword != "",
            email != "" else { return false }
        return true
    }
    
    static func isFilled(name: String?, bornDate: String?, height: String?, address: String?, phone: String?) -> Bool {
        guard let name = name,
            let bornDate = bornDate,
            let height = height,
            let address = address,
            let phone = phone,
            name != "",
            bornDate != "",
            height != "",
            address != "",
            phone != "" else { return false }
        return true
    }
    
    static func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
