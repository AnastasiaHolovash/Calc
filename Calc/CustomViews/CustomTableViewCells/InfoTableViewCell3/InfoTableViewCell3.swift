//
//  InfoTableViewCell3.swift
//  Calc
//
//  Created by Головаш Анастасия on 07.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class InfoTableViewCell3: UITableViewCell {

    
    @IBOutlet weak var viewWithShadow: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = mainBackgroundColor
        viewWithShadow.addShadow()
    }
    
}
