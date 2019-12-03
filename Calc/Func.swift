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


func stringResult(_ arcFi: Double, _ stringResultModuleZ: String) -> String {
    let stringResult:String
    if arcFi < 0{
        stringResult = stringResultModuleZ + "e-i" + String(format: "%.4f", -arcFi) + "˚"
    }else {
        stringResult = stringResultModuleZ + "ei" + String(format: "%.4f", arcFi) + "˚"
    }
    return stringResult
}


func attributedStringResult(_ moduleZ: Double, _ arcFi: Double) -> (NSAttributedString, Bool) {
    let stringResultModuleZ = String(format: "%.4f", moduleZ)
    let fullstringResult = stringResult(arcFi, stringResultModuleZ)
    
    let font:UIFont? = UIFont(name: "Helvetica", size:40)
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

func complexToExp(signIm: String?, signRe: String?, complexIm: String?, complexRe:String?) -> (Double, Double) {
    
    guard let signIm = signIm,
          let signRe = signRe,
          let complexIm = complexIm,
          let complexRe = complexRe else { return (0, 0) }
    
    
    let textIm = (signIm + complexIm).replacingOccurrences(of: ",", with: ".")
    let textRe = (signRe + complexRe).replacingOccurrences(of: ",", with: ".")

    let Im = Double(textIm) ?? 0
    let Re = Double(textRe) ?? 0

    let moduleZ = sqrt(pow(Im, 2) + pow(Re, 2))
    let arcFi = rad(atan(Im / Re))
    return (moduleZ, arcFi)
}

//func plus(<#parameters#>) -> <#return type#> {
//    
//}
