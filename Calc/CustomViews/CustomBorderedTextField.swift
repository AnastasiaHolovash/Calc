//
//  CustomBorderedTextField.swift
//  Calc
//
//  Created by Головаш Анастасия on 10.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class CustomBorderedTextField: UIView {
    
    let textField = UITextField()
    
    
    override func layoutSubviews() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2.5
        self.backgroundColor = mainBackgroundColor
        
        textField.backgroundColor = mainBackgroundColor
        textField.borderStyle = .none
        textField.font = UIFont(name: "Helvetica", size: CGFloat(25))
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = CGFloat(16)
        textField.clearButtonMode = .always
        textField.keyboardType = .decimalPad
        textField.placeholder = "0.0"
        
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 4),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 116),
            textField.heightAnchor.constraint(equalToConstant: 34),
        ])
        
    }
    
    
}
