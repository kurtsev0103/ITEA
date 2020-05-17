//
//  ContactTableViewCell.swift
//  ITEA_07
//
//  Created by Oleksandr Kurtsev on 15/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import CoreData

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    
    static let identifier = "ContactTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ContactTableViewCell", bundle: nil)
    }
    
    func configure(with contact: NSManagedObject) {
        //Установка Фото
        if contact.value(forKeyPath: "gender") as? Bool == true {
            contactImageView.image = UIImage(named: "man")
        } else {
            contactImageView.image = UIImage(named: "woman")
        }
        //Установка Имени и Фамилии
        var str = ""
        if let name = contact.value(forKeyPath: "name") as? String {
            str += name + " "
        }
        if let surname = contact.value(forKeyPath: "surname") as? String {
            str += surname
        }
        contactNameLabel.text = str
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
