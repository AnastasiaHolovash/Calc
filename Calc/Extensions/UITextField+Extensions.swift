//
//  UITextField+Extensions.swift
//  Calc
//
//  Created by Головаш Анастасия on 09.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension UITextField {
    func setRoundedBourder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2.5
    }
}
