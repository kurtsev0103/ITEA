//
//  CustomLabel.swift
//  ITEA_03
//
//  Created by Oleksandr Kurtsev on 07/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }

    private func setupLabel() {
        textColor             = .white
        textAlignment         = .center
        font                  = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 20)
    }

}
