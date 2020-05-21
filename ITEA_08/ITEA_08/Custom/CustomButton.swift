//
//  CustomButton.swift
//  ITEA_08
//
//  Created by Oleksandr Kurtsev on 17/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        setTitleColor(.black, for: .normal)
        
        backgroundColor     = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        titleLabel?.font    = UIFont(name: "AvenirNext-DemiBold", size: 20)
        layer.cornerRadius  = 25
        layer.borderWidth   = 3.0
        layer.borderColor   = UIColor.darkGray.cgColor
    }

    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 1
        shake.autoreverses  = false
        
        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        layer.add(shake, forKey: "position")
    }
}
