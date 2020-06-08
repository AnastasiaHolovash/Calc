//
//  CustomViewFuncs.swift
//  Calc
//
//  Created by Головаш Анастасия on 09.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

let plusImage = UIImage(systemName: "plus.circle.fill")
let minusImage = UIImage(systemName: "minus.circle.fill")

func updateButton(button: UIButton, isPlus: inout Bool) {
    if isPlus {
        button.setBackgroundImage(minusImage, for: .normal)
        isPlus = false
    } else {
        button.setBackgroundImage(plusImage, for: .normal)
        isPlus = true
    }
}
