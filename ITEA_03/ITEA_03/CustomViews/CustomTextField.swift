//
//  CustomTextField.swift
//  ITEA_03
//
//  Created by Oleksandr Kurtsev on 07/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    private func setUpField() {
        tintColor             = .white
        textColor             = .darkGray
        textAlignment         = .center
        font                  = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 20)
        backgroundColor       = UIColor(white: 1.0, alpha: 0.8)
        autocorrectionType    = .no
        layer.cornerRadius    = 25.0
        clipsToBounds         = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont   = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 18)!
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
             NSAttributedString.Key.font: placeholderFont])
        
        let indentView        = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        leftView              = indentView
        leftViewMode          = .always
    }

}
