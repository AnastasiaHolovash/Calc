//
//  InfoTableViewCell.swift
//  Calc
//
//  Created by Головаш Анастасия on 04.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewWithShadow: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var twoLinestextLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = mainBackgroundColor
        viewWithShadow.addShadow()
        
    }
    
}
