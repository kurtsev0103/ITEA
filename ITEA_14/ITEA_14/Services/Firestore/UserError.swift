//
//  UserError.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 13/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the input fields", comment: "")
        case .photoNotExist:
            return NSLocalizedString("User did not select photo", comment: "")
        }
    }
}
