//
//  UIView+Extensions.swift
//  Calc
//
//  Created by Головаш Анастасия on 08.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow() {
        backgroundColor = infoPresentBackgroundColor
        layer.cornerRadius = 20
        
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1
        layer.shadowColor = shadowColor.cgColor
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    func setInfoPresentStyle() {
        self.backgroundColor = infoPresentBackgroundColor
        self.layer.cornerRadius = 20
    }
    
    
    func addShadowForLabel() {
        self.backgroundColor = infoPresentBackgroundColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 8
    }
    
}

