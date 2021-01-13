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
    
    
    /// For exponential representation for too big numbers
    mutating func findTheDegreeOfBigNumbers() -> NSRange? {
        
        if let indexOfUpperSign = self.firstIndex(of: "^") {
            
            self.remove(at: indexOfUpperSign)
            let upperSignLocation = self[..<indexOfUpperSign].count
            
            var i = upperSignLocation
            for simbol in self[indexOfUpperSign...] {
                if Int(String(simbol)) == nil {
                    break
                }
                i += 1
            }
            let length = i - upperSignLocation
            
            return NSRange(location: upperSignLocation, length: length)
        }
        return nil
    }
    
    
    /// Finds NSRange for part of string after ")"
    func findTheDegreeOfNuberRange() -> NSRange? {
        
        if let indexOfCloseParenth = self.firstIndex(of: ")") {
            
            let location = self[..<indexOfCloseParenth].count + 1
            let length = self[indexOfCloseParenth...].count - 1
            
            return NSRange(location: location, length: length)
        }
        return nil
    }
}
