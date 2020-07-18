//
//  ChangeSignButton.swift
//  Calc
//
//  Created by Головаш Анастасия on 19.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

protocol ChangeSignBottomsDelegate {
    func recalculate()
}


class ChangeSignButton: UIButton {
    
    let plusImage = UIImage(named: "Button-Plus")
    let minusImage = UIImage(named: "Button-Minus")

    //MARK:- remove isPlus !!!
    
    func updateButton(isPlus: inout Bool) {
        if isPlus {
            self.setBackgroundImage(minusImage, for: .normal)
            isPlus = false
        } else {
            self.setBackgroundImage(plusImage, for: .normal)
            isPlus = true
        }
    }
    
}
