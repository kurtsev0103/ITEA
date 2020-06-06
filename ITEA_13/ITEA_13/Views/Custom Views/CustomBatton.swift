//
//  UIButton + Extension.swift
//  ITEA_13
//
//  Created by Oleksandr Kurtsev on 05/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

@IBDesignable class CustomBatton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtonShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButtonShadow()
    }
    
    private func setupButtonShadow() {
        layer.cornerRadius  = 5
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowRadius  = 5
        layer.shadowOpacity = 0.2
        layer.shadowOffset  = CGSize(width: 0, height: 4)
    }
}
