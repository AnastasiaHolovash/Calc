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
    if moduleZ.isNaN || arcFi.isNaN {
        return NSLocalizedString("Uncertainty", comment: "")
    } else {
        let stringModuleZ = "\(moduleZ.smartRound(decimalPlases: decimalPlases))"
        if arcFi < 0{
            return stringModuleZ + "e-i" + "\((-arcFi).smartRound(decimalPlases: decimalPlases))" + "°"
        }else {
            return stringModuleZ + "ei" + "\(arcFi.smartRound(decimalPlases: decimalPlases))" + "°"
        }
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

    let eIndex = fullstringResult.lastIndex(of: "e") ?? fullstringResult.endIndex
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
    if Re.isNaN || Im.isNaN {
        return NSLocalizedString("Uncertainty", comment: "")
    } else {
        if Im < 0 {
            return "\(Re.smartRound(decimalPlases: decimalPlases))" + " - i" + "\((-Im).smartRound(decimalPlases: decimalPlases))"
        } else {
            return "\(Re.smartRound(decimalPlases: decimalPlases))" + " + i" + "\(Im.smartRound(decimalPlases: decimalPlases))"
        }
    }
}


/**
Creates a string of number in a complex form using scientific formating.
 
- Parameters:
    - Re:The real part of the complex number.
    - Im: The imaginary part of the complex number.
    - decimalPlases: The required number of digits after the floating point. The default equel 4.
 
- Returns: String of complex number.
*/
func complexNumberToStringWithFormating(Re: Double, Im: Double, roundTo decimalPlases: Int = 4) -> String {
    if Re.isNaN || Im.isNaN {
        return NSLocalizedString("Uncertainty", comment: "")
    } else {
        
        var im: String {
            if abs(Im) > 10000 {
                return Im > 0 ? (Formatter.scientific.string(for: Im) ?? "").remuvePlus()
 : (Formatter.scientific.string(for: -Im) ?? "").remuvePlus()
            } else {
                return Im > 0 ? "\(Im.smartRound(decimalPlases: decimalPlases))" : "\((-Im).smartRound(decimalPlases: decimalPlases))"
            }
        }
    
        var re: String {
            let formatedRe = (Formatter.scientific.string(for: Re) ?? "").remuvePlus()
            return abs(Re) > 10000 ? formatedRe : "\(Re.smartRound(decimalPlases: decimalPlases))"
        }
        
    
        return Im > 0 ? re + " + i" + im : re + " - i" + im
        
        
//        let result = NSMutableAttributedString()
//        result.append(re)
//        Im > 0 ? result.append(NSAttributedString(string: " + i")) : result.append(NSAttributedString(string: " - i"))
//        result.append(im)
//
//        return result
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


/**
Creates a string of number in a exponensial form.
 
- Parameters:
   -  modulZ: Module of number in exponential form.
   -  arc: Angle of number in exponential form in degrees.
   - decimalPlases: The required number of digits after the floating point. The default value is 4.
 
- Returns: String of complex number.
*/
func expNumberToStringWithFormating(moduleZ: Double, arcFi: Double, roundTo decimalPlases: Int = 4) -> String {
    if moduleZ.isNaN || arcFi.isNaN {
        return NSLocalizedString("Uncertainty", comment: "")
    } else {
        
        var stringModuleZ: String {
            let formated = (Formatter.scientific.string(for: moduleZ) ?? "").remuvePlus()
            return abs(moduleZ) > 10000 ? formated : "\(moduleZ.smartRound(decimalPlases: decimalPlases))"
        }
        
        var stringArcFi: String {
            return arcFi > 0 ? "\(arcFi.smartRound(decimalPlases: decimalPlases))" : "\((-arcFi).smartRound(decimalPlases: decimalPlases))"
        }
        
        return arcFi < 0 ? stringModuleZ + "∙e-i" + "\(stringArcFi)" + "°" : stringModuleZ + "∙ei" + "\(stringArcFi)" + "°"
        
    }
}


/**
- Parameters:
   -  fullstringResult: String of complex number in a exponensial form.
   -  fontSize: Font size of module of number. Size of angle calculated automatically.  The default value is 20.
 
- Returns: Attributed String of complex number.
*/
func expAttributedStringResultWithFormating(fullstringResult: inout String, fontSize: Int = 20) -> NSAttributedString {
    let firstSymbolFont: UIFont? = UIFont.systemFont(ofSize: 15, weight: .light)
    
    /// Font for the number before the exponent.
    let font: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize))
    
    /// Font for exponent degree.
    let fontSuper: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize * 5 / 6))
    
    /// Ranges which should be atttributed
    var ranges: [NSRange] = []
    
    fullstringResult = " " + fullstringResult
    
    /// Part of string before "√"
    if let degreeOfTheRootRange = fullstringResult.findTheDegreeOfTheRootRange() {
        ranges.append(degreeOfTheRootRange)
    }
    
    /// For exponential representation for too big numbers
    if let degreeOfBigNumberRange = fullstringResult.findTheDegreeOfBigNumbers() {
        ranges.append(degreeOfBigNumberRange)
    }
    
    /// Part of string after "e" before ")"
    let eIndex = fullstringResult.firstIndex(of: "e") ?? fullstringResult.endIndex
    let eLocation = fullstringResult[..<eIndex].count + 1
    var length = fullstringResult.count - eLocation
    
    if let indexOfClosePartnth = fullstringResult.firstIndex(of: ")") {
        
        let lengthAfterClosePartnth = fullstringResult[indexOfClosePartnth...].count
        length -= lengthAfterClosePartnth
    }
    ranges.append(NSRange(location: eLocation, length: length))
    
    /// If there is number after ")"
    if let afterClosePartnthRange = fullstringResult.findTheDegreeOfNuberRange() {
        ranges.append(afterClosePartnthRange)
    }
    
    /// Seting the attributes
    let attString: NSMutableAttributedString = NSMutableAttributedString(string: fullstringResult, attributes: [.font:font!])
    attString.setAttributes([.font:firstSymbolFont!], range: NSRange(location: 0, length: 1))
    
    for i in 0..<ranges.count {
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: ranges[i])
    }
    attString.endEditing()
    
    return attString
}


/**
- Parameters:
   -  fullstringResult: String of complex number in a exponensial form.
   -  fontSize: Font size of module of number. Size of angle calculated automatically.  The default value is 20.
 
- Returns: Attributed String of complex number.
*/
func complexAttributedStringResultWithFormating(fullstringResult: inout String, fontSize: Int = 20) -> NSAttributedString {
    let firstSymbolFont: UIFont? = UIFont.systemFont(ofSize: 15, weight: .light)
    
    /// Font for the number before the exponent.
    let font: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize))
    
    /// Font for exponent degree.
    let fontSuper: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize * 5 / 6))
    
    /// Ranges which should be atttributed
    var ranges: [NSRange] = []
    
    fullstringResult = " " + fullstringResult
    
    /// Part of string before "√"
    if let degreeOfTheRootRange = fullstringResult.findTheDegreeOfTheRootRange() {
        ranges.append(degreeOfTheRootRange)
    }
    
    /// For exponential representation for too big numbers
    while let degreeOfBigNumberRange = fullstringResult.findTheDegreeOfBigNumbers() {
        ranges.append(degreeOfBigNumberRange)
    }
    
    /// If there is number after ")"
    if let afterClosePartnthRange = fullstringResult.findTheDegreeOfNuberRange() {
        ranges.append(afterClosePartnthRange)
    }
    
    /// Seting the attributes
    let attString: NSMutableAttributedString = NSMutableAttributedString(string: fullstringResult, attributes: [.font:font!])
    attString.setAttributes([.font:firstSymbolFont!], range: NSRange(location: 0, length: 1))
    
    for i in 0..<ranges.count {
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: ranges[i])
    }
    attString.endEditing()
    
    return attString
}
