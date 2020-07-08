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
        self.backgroundColor = mainBackgroundColor
        viewWithShadow.addShadow()
    }
    
}
