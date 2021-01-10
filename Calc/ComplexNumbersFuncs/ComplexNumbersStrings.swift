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


func complexNumberToStringWithFormating(Re: Double, Im: Double, roundTo decimalPlases: Int = 4) -> NSAttributedString {
    if Re.isNaN || Im.isNaN {
        return NSAttributedString(string: NSLocalizedString("Uncertainty", comment: ""))
    } else {
        
        var im: NSAttributedString {
            if abs(Im) > 10000 {
                return Im > 0 ? Im.scientificFormatted() : (-Im).scientificFormatted()
            } else {
                return Im > 0 ? NSAttributedString(string: "\(Im.smartRound(decimalPlases: decimalPlases))") : NSAttributedString(string: "\((-Im).smartRound(decimalPlases: decimalPlases))")
            }
        }
    
        var re: NSAttributedString {
            return abs(Re) > 10000 ? Re.scientificFormatted() : NSAttributedString(string: "\(Re.smartRound(decimalPlases: decimalPlases))")
        }
        
        let result = NSMutableAttributedString()
        result.append(re)
        Im > 0 ? result.append(NSAttributedString(string: " + i")) : result.append(NSAttributedString(string: " - i"))
        result.append(im)
        
        return result
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
        
        if arcFi < 0{
            return stringModuleZ + "∙e-i" + "\(stringArcFi)" + "°"
        } else {
            return stringModuleZ + "∙ei" + "\(stringArcFi)" + "°"
        }
    }
}


/**
- Parameters:
   -  fullstringResult: String of complex number in a exponensial form.
   -  fontSize: Font size of module of number. Size of angle calculated automatically.  The default value is 20.
 
- Returns: Attributed String of complex number.
*/
func attributedStringResultWithFormating(fullstringResult: inout String, fontSize: Int = 20) -> NSAttributedString {
    /// Font for the number before the exponent.
    let font: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize))
    /// Font for exponent degree.
    let fontSuper: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize * 5 / 6))

    var ranges: [NSRange] = []
    
    var eIndex: String.Index
    var eLocation: Int
    
    if let upperSignIndex = fullstringResult.firstIndex(of: "^") {
        fullstringResult.remove(at: upperSignIndex)
        let upperSignLocation = fullstringResult[..<upperSignIndex].count
        
        eIndex = fullstringResult.firstIndex(of: "e") ?? fullstringResult.endIndex
        eLocation = fullstringResult[..<eIndex].count - 1
        
        let length = eLocation - upperSignLocation
        ranges.append(NSRange(location: upperSignLocation, length: length))
    }
    
    eIndex = fullstringResult.firstIndex(of: "e") ?? fullstringResult.endIndex
    
    eLocation = fullstringResult[..<eIndex].count + 1
    var length = fullstringResult.count - eLocation
    
    if let indexOfClosePartnth = fullstringResult.firstIndex(of: ")") {
        
        let lengthAfterClosePartnth = fullstringResult[indexOfClosePartnth...].count
        length -= lengthAfterClosePartnth
        
        if lengthAfterClosePartnth > 1 {
            
            let afterClosePartnthLocation = [..<indexOfClosePartnth].count + 1
            ranges.append(NSRange(location: afterClosePartnthLocation, length: lengthAfterClosePartnth - 1))
        }
    }
    
    ranges.append(NSRange(location: eLocation, length: length))
    
    let attString: NSMutableAttributedString = NSMutableAttributedString(string: fullstringResult, attributes: [.font:font!])
    
    for i in 0..<ranges.count {
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: ranges[i])
    }
    
    return attString
}
