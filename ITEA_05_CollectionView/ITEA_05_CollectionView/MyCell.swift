//
//  MyCell.swift
//  ITEA_05_CollectionView
//
//  Created by Oleksandr Kurtsev on 09/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!

    static let identifier = "myIdentifier"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }

    static func nib() -> UINib {
        return UINib(nibName: "MyCell", bundle: nil)
    }
}
