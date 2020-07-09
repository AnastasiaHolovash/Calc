//
//  ComplexNumbersStrings.swift
//  Calc
//
//  Created by Головаш Анастасия on 10.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

/**
Creates a string of number in a exponensial form.
 
- Parameters:
   -  modulZ: Module of number in exponential form.
   -  arc: Angle of number in exponential form in degrees.
   - decimalPlases: The required number of digits after the floating point. The default value is 4.
 
- Returns: String of complex number.
*/
func expNumberToString(moduleZ: Double, arcFi: Double, roundTo decimalPlases: Int = 4) -> String {
    let stringModuleZ = "\(moduleZ.smartRound(decimalPlases: decimalPlases))"
    if arcFi < 0{
        return stringModuleZ + "e-i" + "\((-arcFi).smartRound(decimalPlases: decimalPlases))" + "°"
    }else {
        return stringModuleZ + "ei" + "\(arcFi.smartRound(decimalPlases: decimalPlases))" + "°"
    }
}


/**
- Parameters:
   -  fullstringResult: String of complex number in a exponensial form.
   -  fontSize: Font size of module of number. Size of angle calculated automatically.  The default value is 20.
 
- Returns: Attributed String of complex number.
*/
func attributedStringResult(fullstringResult: String, fontSize: Int = 20) -> NSAttributedString {
    /// Font for the number before the exponent.
    let font: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize))
    /// Font for exponent degree.
    let fontSuper: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize * 5 / 6))
     
    let attString: NSMutableAttributedString = NSMutableAttributedString(string: fullstringResult, attributes: [.font:font!])

    let eIndex = fullstringResult.firstIndex(of: "e") ?? fullstringResult.endIndex
    let eLocation = fullstringResult[..<eIndex].count + 1

    var length = fullstringResult.count - eLocation
    if fullstringResult.firstIndex(of: ")") != nil {
        length -= 1
    }
    attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location: eLocation, length: length))
    return attString
}


/**
Creates a string of number in a complex form.
 
- Parameters:
    - Re:The real part of the complex number.
    - Im: The imaginary part of the complex number.
    - decimalPlases: The required number of digits after the floating point. The default equel 4.
 
- Returns: String of complex number.
*/
func complexNumberToString(Re: Double, Im: Double, roundTo decimalPlases: Int = 4) -> String {
    if Im < 0 {
        return "\(Re.smartRound(decimalPlases: decimalPlases))" + " - i" + "\((-Im).smartRound(decimalPlases: decimalPlases))"
    } else {
        return "\(Re.smartRound(decimalPlases: decimalPlases))" + " + i" + "\(Im.smartRound(decimalPlases: decimalPlases))"
    }
}


/**
Converts number to Double.
 
- Parameters:
   -  sign: Sign of the number (true if plus; false if minus).
   -  number: Number in String.
 
- Returns: Double number.
*/
func makeANumber(sign: Bool, number: String) -> Double {
    let double = Double(number.replacingOccurrences(of: ",", with: ".")) ?? 0
    if sign {
        return double
    } else {
        return -double
    }
}
