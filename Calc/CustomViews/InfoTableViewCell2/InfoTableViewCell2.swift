//
//  InfoTableViewCell2.swift
//  Calc
//
//  Created by Головаш Анастасия on 05.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class InfoTableViewCell2: UITableViewCell {

    @IBOutlet weak var viewWithShadow: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var otherTextLabel: UILabel!
    @IBOutlet weak var formulaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 0.945, green: 0.949, blue: 0.965, alpha: 1)
        viewWithShadow.layer.cornerRadius = 20
        viewWithShadow.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        viewWithShadow.layer.shadowOpacity = 1
        viewWithShadow.layer.shadowOffset = CGSize(width: 0, height: 1)
        viewWithShadow.layer.shadowRadius = 8
    }
    
}
