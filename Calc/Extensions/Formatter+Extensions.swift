//
//  Formatter+Extensions.swift
//  Calc
//
//  Created by Головаш Анастасия on 24.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension Formatter {
    
    static let scientific: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.locale = Locale(identifier: "en_US")
        
        formatter.positiveFormat = "0.###E+0"
        formatter.exponentSymbol = "∙10^"
        
        return formatter
    }()
}

extension String {
    func remuvePlus() -> String {
        var result = self
        if let indexOfPlus = self.firstIndex(of: "+") {
            result.remove(at: indexOfPlus)
        }
        return result
    }
}

extension Numeric where Self: Comparable {
    
    func scientificFormatted() -> NSMutableAttributedString {
        
        let stringFromFormatter = (Formatter.scientific.string(for: self) ?? "").remuvePlus()
        
        /// ["4.267∙10", "-1"] example of  `splitedString`
        let splitedString = stringFromFormatter.split(separator: "^")

        let result = NSMutableAttributedString()

        guard let font: UIFont = UIFont(name: "Helvetica", size:18) else { return NSMutableAttributedString() }
        guard let fontUpper: UIFont = UIFont(name: "Helvetica", size:12) else { return NSMutableAttributedString() }
        
        let attributedPart1: NSMutableAttributedString = NSMutableAttributedString(string: String(splitedString[0]), attributes: [.font: font])
        let attributedPart2: NSMutableAttributedString = NSMutableAttributedString(string: String(splitedString[1]), attributes: [.font: fontUpper,.baselineOffset:10])

        result.append(attributedPart1)
        result.append(attributedPart2)

        return result
    }
}
    
