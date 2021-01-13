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
        self.backgroundColor = infoPresentBackgroundColor
        self.layer.cornerRadius = 20
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = shadowColor.cgColor
        
        
//        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        
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

