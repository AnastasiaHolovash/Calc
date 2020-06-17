//
//  TableViewCell.swift
//  Calc
//
//  Created by Головаш Анастасия on 17.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var viewWithShadow: UIView!
    @IBOutlet weak var operationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewWithShadow.layer.cornerRadius = 20
        viewWithShadow.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        viewWithShadow.layer.shadowOpacity = 1
        viewWithShadow.layer.shadowOffset = CGSize(width: 0, height: 1)
        viewWithShadow.layer.shadowRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
//            viewWithShadow.isHighlighted = true
            self.contentView.backgroundColor = .white
        } else {
            self.contentView.backgroundColor = .white
        }
    }
    
}
