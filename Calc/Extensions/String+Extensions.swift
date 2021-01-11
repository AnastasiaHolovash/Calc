//
//  String+Extensions.swift
//  Calc
//
//  Created by Головаш Анастасия on 27.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension String {
    func addParentheses() -> String {
        return "(\(self))"
    }
    
    func exponent(textFontSize: Int = 20) -> NSMutableAttributedString {
        /// Font for  degree.
        let fontSuper: UIFont? = UIFont(name: "Helvetica", size: CGFloat(textFontSize * 5 / 6))
        return NSMutableAttributedString(string: self, attributes: [.font:fontSuper!,.baselineOffset:10])
    }
    
    
    /// Finds NSRange for part of string before "√"
    func findTheDegreeOfTheRootRange() -> NSRange? {
        
        if let indexOfRoot = self.firstIndex(of: "√") {
            
            let location = 1
            let length = self[..<indexOfRoot].count - 1
            return NSRange(location: location, length: length)
        }
        return nil
    }
}
