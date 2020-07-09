//
//  CustomViewFuncs.swift
//  Calc
//
//  Created by Головаш Анастасия on 09.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

let plusImage = UIImage(named: "Button-Plus")
let minusImage = UIImage(named: "Button-Minus")

func updateButton(button: UIButton, isPlus: inout Bool) {
    if isPlus {
        button.setBackgroundImage(minusImage, for: .normal)
        isPlus = false
    } else {
        button.setBackgroundImage(plusImage, for: .normal)
        isPlus = true
    }
}
