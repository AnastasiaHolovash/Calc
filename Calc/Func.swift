//
//  Func.swift
//  Calc
//
//  Created by Головаш Анастасия on 03.12.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit


func alert() -> UIAlertController {
    let alert = UIAlertController(title: "Notice", message: "The values ​​you entered are too large", preferredStyle: .alert)
    let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(okBtn)
    return alert
}


func rad(_ number: Double) -> Double {
    return number * 180 / .pi
}


func degree(_ number: Double) -> Double {
    return number * .pi / 180
}





func attributedStringResult(_ moduleZ: Double, _ arcFi: Double) -> (NSAttributedString, Bool) {
    let stringResultModuleZ = String(format: "%.4f", moduleZ)
    let fullstringResult = stringResultforExpForm(arcFi, stringResultModuleZ)
    
    let font:UIFont? = UIFont(name: "Helvetica", size:30)
    let fontSuper:UIFont? = UIFont(name: "Helvetica", size:20)
     
    let attString:NSMutableAttributedString = NSMutableAttributedString(string: fullstringResult, attributes: [.font:font!])
     attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:stringResultModuleZ.count + 1 ,length:fullstringResult.count - stringResultModuleZ.count - 1))
    if fullstringResult.count > 20 {
        return (NSMutableAttributedString(string: "No result", attributes: [.font:font!]), true)
    } else {
        return (attString, false)
    }
}

func changeSign(_ buttton: UIButton) {
    if buttton.title(for: .normal) == "+"{
        buttton.setTitle("-", for: .normal)
    } else {
        buttton.setTitle("+", for: .normal)
    }
}

func doubleComplexToExp(Im: Double, Re: Double) -> (moduleZ: Double, arcFi: Double) {
    let moduleZ = sqrt(pow(Im, 2) + pow(Re, 2))
    let arcFi = rad(atan(Im / Re))
    return (moduleZ, arcFi)
}

func complexToExp(signIm: String?, signRe: String?, complexIm: String?, complexRe:String?) -> (Double, Double) {
    
    guard let signIm = signIm,
          let signRe = signRe,
          let complexIm = complexIm,
          let complexRe = complexRe else { return (0, 0) }
    
    
    let textIm = (signIm + complexIm).replacingOccurrences(of: ",", with: ".")
    let textRe = (signRe + complexRe).replacingOccurrences(of: ",", with: ".")

//    let Im = Double(textIm) ?? 0
//    let Re = Double(textRe) ?? 0

//    let moduleZ = sqrt(pow(Im, 2) + pow(Re, 2))
//    let arcFi = rad(atan(Im / Re))
//    return (moduleZ, arcFi)
    return doubleComplexToExp(Im: Double(textIm) ?? 0, Re: Double(textRe) ?? 0)
}


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


func stringResultforComplexForm(_ Im: Double, _ Re: Double) -> String {
    if Im < 0 {
        return String(format: "%.4f", Re) + " - i" + String(format: "%.4f", -Im)
    } else {
        return String(format: "%.4f", Re) + " + i" + String(format: "%.4f", Im)
    }
}


func stringResultforExpForm(_ arcFi: Double, _ stringResultModuleZ: String) -> String {
    let stringResult:String
    if arcFi < 0{
        stringResult = stringResultModuleZ + "e-i" + String(format: "%.4f", -arcFi) + "˚"
    }else {
        stringResult = stringResultModuleZ + "ei" + String(format: "%.4f", arcFi) + "˚"
    }
    return stringResult
}


func allDataToComlexForm(_ modulZSignButton: UIButton, _ angleSignButton: UIButton, _ beforeExpTextField: UITextField, _ angleExpTextField: UITextField, _ signReButton: UIButton, _ signImButton: UIButton, _ complexReTextField: UITextField, _ complexImTextField: UITextField, _ expView: UIView!) ->  (Re: Double, Im: Double){
            var re: Double?
            var im: Double?
            if expView.isHidden == false {
    //            print("-------EXP--------")
                let result = expToComlex(signModulZ: modulZSignButton.title(for: .normal), signArc: angleSignButton.title(for: .normal), modulZ:  beforeExpTextField.text, arc: angleExpTextField.text)
                re = result.Re
                im = result.Im
            } else {
                re = Double((signReButton.title(for: .normal) ?? "") + (complexReTextField.text ?? ""))
                im = Double((signImButton.title(for: .normal) ?? "") + (complexImTextField.text ?? ""))
            }
            guard let re1 = re,
                  let im1 = im else { return (Re: 0, Im: 0)}
    
    return (Re: re1, Im: im1)

}


func plus(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (Re1 + Re2), Im: (Im1 + Im2))
}
func minus(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (Re1 - Re2), Im: (Im1 - Im2))
}
func multiply(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (Re1*Re2 - Im1*Im2), Im: (Re1*Im2 + Re2*Im1))
}
func divide(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    let re = (Re1*Re2 + Im1*Im2) / (pow(Re2, 2) + pow(Im2, 2))
    let im = -(Re1*Im2 - Re2*Im1) / (pow(Re2, 2) + pow(Im2, 2))
    return (Re: re, Im: im)
}
