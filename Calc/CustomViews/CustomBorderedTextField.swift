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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        layer.cornerRadius = self.frame.height / 2.5
        backgroundColor = mainBackgroundColor
        
        textField.backgroundColor = mainBackgroundColor
        textField.borderStyle = .none
        textField.font = UIFont(name: "Helvetica", size: 20)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 16
        textField.clearButtonMode = .always
        textField.keyboardType = .decimalPad
        textField.placeholder = "0.0"
        
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 4),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -4),
            textField.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
}
