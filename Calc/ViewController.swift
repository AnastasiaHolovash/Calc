//
//  ViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 27.11.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var beforeExpTextField: UITextField!
    @IBOutlet weak var angleExpTextField: UITextField!
    @IBOutlet weak var complexReTextField: UITextField!
    @IBOutlet weak var complexImTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var modulZSignButton: UIButton!
    @IBOutlet weak var angleSignButton: UIButton!
    @IBOutlet weak var signReButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var convertToComplexButton: UIButton!
    @IBOutlet weak var convertToExpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertToComplexButton.layer.cornerRadius = CGFloat((Double(convertToComplexButton.frame.height) ) / 2.0)
        convertToExpButton.layer.cornerRadius = CGFloat((Double(convertToExpButton.frame.height) ) / 2.0)

        
    }
    
    func hideKeyboard() {
        beforeExpTextField.resignFirstResponder()
        angleExpTextField.resignFirstResponder()
        complexImTextField.resignFirstResponder()
        complexReTextField.resignFirstResponder()
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

    @IBAction func didPressConvert(_ sender: UIButton) {
        let textIm = (signButton.title(for: .normal) ?? "") + (complexImTextField.text ?? "")
        let textRe = (signReButton.title(for: .normal) ?? "") + (complexReTextField.text ?? "")

        let Im = textIm.replacingOccurrences(of: ",", with: ".")
        let Re = textRe.replacingOccurrences(of: ",", with: ".")
        
        let Im2 = pow(Double(Im) ?? 0, Double(2))
        let Re2 = pow(Double(Re) ?? 0, Double(2))

        let moduleZ = sqrt(Im2 + Re2)
        
        let arcFi = rad(atan((Double(Im) ?? Double(1)) / (Double(Re) ?? Double(1))))
        let stringResultModuleZ = String(format: "%.4f", moduleZ)
       
        let font:UIFont? = UIFont(name: "Helvetica", size:40)
        let fontSuper:UIFont? = UIFont(name: "Helvetica", size:20)
        
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: stringResult(arcFi, stringResultModuleZ), attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:stringResultModuleZ.count + 1 ,length:stringResult(arcFi, stringResultModuleZ).count - stringResultModuleZ.count - 1))
        resultLabel.attributedText = attString
        
        hideKeyboard()
    }
    
    @IBAction func didPressConvertToComplex(_ sender: Any) {
        let beforeExp = (modulZSignButton.title(for: .normal) ?? "") + (beforeExpTextField.text ?? "")
        let angleExp = (angleSignButton.title(for: .normal) ?? "") + (angleExpTextField.text ?? "")

        let moduleZ = beforeExp.replacingOccurrences(of: ",", with: ".")
        let angleFi = angleExp.replacingOccurrences(of: ",", with: ".")
         
        let Re = (Double(moduleZ) ?? 0) * cos(degree(Double(angleFi) ?? 0))
        let Im = (Double(moduleZ) ?? 0) * sin(degree(Double(angleFi) ?? 0))
        
        resultLabel.text = String(format: "%.4f", Re) + " + i" + String(format: "%.4f", Im)
        hideKeyboard()
    }
    
    @IBAction func didChangeModulZSign(_ sender: UIButton) {
        if modulZSignButton.title(for: .normal) == "+"{
            modulZSignButton.setTitle("-", for: .normal)
        }else{
            modulZSignButton.setTitle("+", for: .normal)
        }
    }
    @IBAction func didChangeAngleSign(_ sender: UIButton) {
        if angleSignButton.title(for: .normal) == "+"{
            angleSignButton.setTitle("-", for: .normal)
        }else{
            angleSignButton.setTitle("+", for: .normal)
        }
    }
    @IBAction func didChangeReSign(_ sender: UIButton) {
        if signReButton.title(for: .normal) == "+"{
            signReButton.setTitle("-", for: .normal)
        }else{
            signReButton.setTitle("+", for: .normal)
        }
    }
    @IBAction func didChangeSign(_ sender: UIButton) {
        if signButton.title(for: .normal) == "+"{
            signButton.setTitle("-", for: .normal)
        }else{
            signButton.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }

}
