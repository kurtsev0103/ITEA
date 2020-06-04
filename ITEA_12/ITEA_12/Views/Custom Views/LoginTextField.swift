//
//  LoginTextField.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 02/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    private func setUpField() {
        tintColor             = .darkGray
        textColor             = .darkGray
        font                  = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 18)
        backgroundColor       = UIColor(white: 1.0, alpha: 0.8)
        autocorrectionType    = .no
        layer.cornerRadius    = 25.0
        clipsToBounds         = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont   = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 18)!
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
             NSAttributedString.Key.font: placeholderFont])
    }

}
