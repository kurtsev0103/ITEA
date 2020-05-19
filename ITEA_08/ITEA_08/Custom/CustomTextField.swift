//
//  CustomTextField.swift
//  ITEA_08
//
//  Created by Oleksandr Kurtsev on 17/05/2020.
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
        tintColor               = .white
        textColor               = .black
        textAlignment           = .center
        font                    = UIFont(name: "AvenirNext-DemiBold", size: 20)
        backgroundColor         = UIColor(white: 1.0, alpha: 0.8)
        returnKeyType           = .done
        autocapitalizationType  = .words
        autocorrectionType      = .no
        layer.cornerRadius      = 25.0
        clipsToBounds           = true
        
        let placeholder         = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont     = UIFont(name: "AvenirNext-DemiBold", size: 20)!
        attributedPlaceholder   = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
             NSAttributedString.Key.font: placeholderFont])
    }
}
