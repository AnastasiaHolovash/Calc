//
//  Func.swift
//  Calc
//
//  Created by Головаш Анастасия on 03.12.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

///Appears when the entered numbers are too large.
func alert() -> UIAlertController {
    let alert = UIAlertController(title: "Notice", message: "The values ​​you entered are too large", preferredStyle: .alert)
    let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(okBtn)
    return alert
}


///Appears when operation is not selected.
func alert2() -> UIAlertController {
    let alert = UIAlertController(title: "", message: "Select the operation, please.", preferredStyle: .alert)
    let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(okBtn)
    return alert
}


///Сonverts radians to degrees.
func rad(_ number: Double) -> Double {
    return number * 180 / .pi
}


///Сonverts degrees to radians.
func degree(_ number: Double) -> Double {
    return number * .pi / 180
}

//MARK: - delete
/**
 Formes an appearance of complex number in exponential form.
 - Parameters:
    - moduleZ: Module of number in exponential form.
    - arcFi: Angle of number in exponential form in degrees.
 - Returns: complex number in exponential form in 'NSAttributedString' with 'Bool' value: 'true' if result is too long to show, 'false' if all is OK
 */
func attributedStringResult_(moduleZ: Double, arcFi: Double, roundTo decimalPlases: Int = 4, fontSize: Int = 30) -> (NSAttributedString, Bool) {
    /// ModuleZ in 'String'. Variable is needed in this function because it is used further.
    let stringModuleZ = String(format: "%.\(decimalPlases)f", moduleZ)
//    let fullstringResult = expNumberToString(arcFi: arcFi, stringModuleZ: stringResultModuleZ)
    let fullstringResult: String
    if arcFi < 0{
        fullstringResult = stringModuleZ + "e-i" + String(format: "%.\(decimalPlases)f", -arcFi) + "°"
    }else {
        fullstringResult = stringModuleZ + "ei" + String(format: "%.\(decimalPlases)f", arcFi) + "°"
    }
    /// Font for the number before the exponent.
    let font: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize))
    /// Font for exponent degree.
    let fontSuper: UIFont? = UIFont(name: "Helvetica", size: CGFloat(fontSize * 2 / 3))
     
    let attString: NSMutableAttributedString = NSMutableAttributedString(string: fullstringResult, attributes: [.font:font!])
     attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:stringModuleZ.count + 1 ,length:fullstringResult.count - stringModuleZ.count - 1))
    if fullstringResult.count > 30 {
        return (NSMutableAttributedString(string: "No result", attributes: [.font:font!]), true)
    } else {
        return (attString, false)
    }
}

func expNumberToString(moduleZ: Double, arcFi: Double, roundTo decimalPlases: Int = 4) -> String {
    let stringModuleZ = "\(moduleZ.smartRound(decimalPlases: decimalPlases))"
    if arcFi < 0{
        return stringModuleZ + "e-i" + "\((-arcFi).smartRound(decimalPlases: decimalPlases))" + "°"
    }else {
        return stringModuleZ + "ei" + "\(arcFi.smartRound(decimalPlases: decimalPlases))" + "°"
    }
}

func attributedStringResult(fullstringResult: String, fontSize: Int = 30) -> NSAttributedString {
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
 Converts a complex number of type "Double" to a number in exponential form of type "Double".
 - Parameter Im: The imaginary part of the complex number.
 - Parameter Re: The real part of the complex number.

 - Returns: (Module of number in exponential form, Angle of number in exponential form in degrees)
 */
func complexToExpNumber(Im: Double, Re: Double) -> (moduleZ: Double, arcFi: Double) {
    let moduleZ = sqrt(pow(Im, 2) + pow(Re, 2))
    let arcFi = rad(atan(Im / Re))
    return (moduleZ, arcFi)
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
Converts an exponential number into a complex number.
- Parameters:
   -  modulZ: Module of number in exponential form.
   -  arc: Angle of number in exponential form in degrees.
- Returns: Complex number.
*/
func expToComplexNumber(modulZ: Double, arc:Double) -> (Re:Double, Im: Double) {
    let Re = modulZ * cos(degree(arc))
    let Im = modulZ * sin(degree(arc))
    return (Re: Re, Im: Im)
}


func convertToComplex(expView: ExpView) -> (Re: Double, Im: Double) {

    let modulZ = makeANumber(sign: expView.beforeExpIsPlus, number: expView.beforeExpTextField.text ?? "")
    let arc = makeANumber(sign: expView.afterExpIsPlus, number: expView.afterExpTextField.text ?? "")

    return expToComplexNumber(modulZ: modulZ, arc: arc)
}


/**
Generates a string of an ful number in a complex form.
- Parameters:
    - Re:The real part of the complex number.
    - Im: The imaginary part of the complex number.
- Returns: String of an ful number.
*/
func complexNumberToString(Re: Double, Im: Double, roundTo decimalPlases: Int = 4) -> String {
    if Im < 0 {
        return "\(Re.smartRound(decimalPlases: decimalPlases))" + " - i" + "\((-Im).smartRound(decimalPlases: decimalPlases))"
    } else {
        return "\(Re.smartRound(decimalPlases: decimalPlases))" + " + i" + "\(Im.smartRound(decimalPlases: decimalPlases))"
    }
}


/**
 Generates a string of an ful number in an exponential form.
 - Parameters:
    - arcFi: Angle of number in exponential form in degrees.
    - stringModuleZ:Module of number in exponential form in 'String'.
 - Returns: String of an ful number.
 */
//func expNumberToString(arcFi: Double, stringModuleZ: String) -> String {
//    let stringResult:String
//    if arcFi < 0{
//        stringResult = stringModuleZ + "e-i" + String(format: "%.4f", -arcFi) + "˚"
//    }else {
//        stringResult = stringModuleZ + "ei" + String(format: "%.4f", arcFi) + "˚"
//    }
//    return stringResult
//}


/// Performs the operation of adding two complex numbers.
func plus(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (Re1 + Re2), Im: (Im1 + Im2))
}
/// Performs the operation of subtraction two complex numbers.
func minus(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (Re1 - Re2), Im: (Im1 - Im2))
}
/// Performs the operation of multiplication two complex numbers.
func multiply(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (Re1*Re2 - Im1*Im2), Im: (Re1*Im2 + Re2*Im1))
}
/// Performs the operation of division two complex numbers.
func divide(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    let re = (Re1*Re2 + Im1*Im2) / (pow(Re2, 2) + pow(Im2, 2))
    let im = (Re2*Im1 - Re1*Im2) / (pow(Re2, 2) + pow(Im2, 2))
    return (Re: re, Im: im)
}
