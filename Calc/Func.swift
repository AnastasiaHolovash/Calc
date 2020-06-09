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

/**
 Formes an appearance of complex number in exponential form.
 - Parameters:
    - moduleZ: Module of number in exponential form.
    - arcFi: Angle of number in exponential form in degrees.
 - Returns: complex number in exponential form in 'NSAttributedString' with 'Bool' value: 'true' if result is too long to show, 'false' if all is OK
 */
func attributedStringResult(_ moduleZ: Double, _ arcFi: Double) -> (NSAttributedString, Bool) {
    /// ModuleZ in 'String'. Variable is needed in this function because it is used further.
    let stringResultModuleZ = String(format: "%.4f", moduleZ)
    let fullstringResult = stringResultforExpForm(arcFi, stringResultModuleZ)
    /// Font for the number before the exponent.
    let font:UIFont? = UIFont(name: "Helvetica", size:30)
    /// Font for exponent degree.
    let fontSuper:UIFont? = UIFont(name: "Helvetica", size:20)
     
    let attString:NSMutableAttributedString = NSMutableAttributedString(string: fullstringResult, attributes: [.font:font!])
     attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:stringResultModuleZ.count + 1 ,length:fullstringResult.count - stringResultModuleZ.count - 1))
    if fullstringResult.count > 20 {
        return (NSMutableAttributedString(string: "No result", attributes: [.font:font!]), true)
    } else {
        return (attString, false)
    }
}

/**
 Сhanges the sign on the button to the opposite.
 
 - Parameter buttton: Button on which you need to change the sign.
 */
func changeSign(_ buttton: UIButton) {
    if buttton.title(for: .normal) == "+"{
        buttton.setTitle("-", for: .normal)
    } else {
        buttton.setTitle("+", for: .normal)
    }
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

// MARK:- need delete
/**
 Converts a complex number into an exponential number.
 - Parameters:
    - signIm: Sign of the imaginary part of the complex number.
    - signRe: Sign of the real part of the complex number.
    -  complexIm: The imaginary part of the complex number.
    -  complexRe: The real part of the complex number.
 - Returns:Exponential number.
 */
func complexToExp(signIm: String?, signRe: String?, complexIm: String?, complexRe:String?) -> (Double, Double) {
    
    guard let signIm = signIm,
          let signRe = signRe,
          let complexIm = complexIm,
          let complexRe = complexRe else { return (0, 0) }
    
    let textIm = (signIm + complexIm).replacingOccurrences(of: ",", with: ".")
    let textRe = (signRe + complexRe).replacingOccurrences(of: ",", with: ".")
    return complexToExpNumber(Im: Double(textIm) ?? 0, Re: Double(textRe) ?? 0)
}

// MARK:- need delete
/**
Converts an exponential number into a complex number.
- Parameters:
   - signModulZ: Sign of the module of number in exponential form.
   - signArc: Sign of the angle of number in exponential form in degrees.
   -  modulZ: Module of number in exponential form.
   -  arc: Angle of number in exponential form in degrees.
- Returns: Complex number.
*/
func expToComlex(signModulZ: String?, signArc: String?, modulZ: String?, arc:String?) -> (Re:Double, Im: Double) {
    
    guard let signModulZ = signModulZ,
          let signArc = signArc,
          let modulZ = modulZ,
          let arc = arc else { return (0, 0) }
    
    let beforeExp = signModulZ + modulZ
    let angleExp = signArc + arc

    let moduleZ = beforeExp.replacingOccurrences(of: ",", with: ".")
    let angleFi = angleExp.replacingOccurrences(of: ",", with: ".")
     
    let Re = (Double(moduleZ) ?? 0) * cos(degree(Double(angleFi) ?? 0))
    let Im = (Double(moduleZ) ?? 0) * sin(degree(Double(angleFi) ?? 0))
    
    return (Re: Re, Im: Im)
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
   - Im: The imaginary part of the complex number.
   - Re:The real part of the complex number.
- Returns: String of an ful number.
*/
func stringResultforComplexForm(_ Im: Double, _ Re: Double) -> String {
    if Im < 0 {
        return String(format: "%.4f", Re) + " - i" + String(format: "%.4f", -Im)
    } else {
        return String(format: "%.4f", Re) + " + i" + String(format: "%.4f", Im)
    }
}

/**
 Generates a string of an ful number in an exponential form.
 - Parameters:
    - arcFi: Angle of number in exponential form in degrees.
    - stringResultModuleZ:Module of number in exponential form in 'String'.
 - Returns: String of an ful number.
 */
func stringResultforExpForm(_ arcFi: Double, _ stringResultModuleZ: String) -> String {
    let stringResult:String
    if arcFi < 0{
        stringResult = stringResultModuleZ + "e-i" + String(format: "%.4f", -arcFi) + "˚"
    }else {
        stringResult = stringResultModuleZ + "ei" + String(format: "%.4f", arcFi) + "˚"
    }
    return stringResult
}



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
    let im = -(Re1*Im2 - Re2*Im1) / (pow(Re2, 2) + pow(Im2, 2))
    return (Re: re, Im: im)
}
