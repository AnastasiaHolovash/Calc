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
    @IBOutlet weak var signButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func rad(_ number: Double) -> Double {
        return number * 180 / .pi
    }
    
    func degree(_ number: Double) -> Double {
        return number * .pi / 180
    }

    @IBAction func didPressConvert(_ sender: UIButton) {
        let textIm = complexImTextField.text ?? ""
        let textRe = complexReTextField.text ?? ""

        let Im = textIm.replacingOccurrences(of: ",", with: ".")
        let Re = textRe.replacingOccurrences(of: ",", with: ".")
        
        let Im2 = pow(Double(Im) ?? 0, Double(2))
        let Re2 = pow(Double(Re) ?? 0, Double(2))

        let moduleZ = sqrt(Im2 + Re2)
        
        let arcFi = rad(atan((Double(Im) ?? Double(1)) / (Double(Re) ?? Double(1))))
        let stringResultModuleZ = String(format: "%.4f", moduleZ)
       
        let font:UIFont? = UIFont(name: "Helvetica", size:40)
        let fontSuper:UIFont? = UIFont(name: "Helvetica", size:20)
        
        let stringResult = stringResultModuleZ + "ei" + String(format: "%.4f", arcFi) + "˚"
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: stringResult, attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:stringResultModuleZ.count + 1 ,length:stringResult.count - stringResultModuleZ.count - 1))
        resultLabel.attributedText = attString
    }
    
    @IBAction func didPressConvertToComplex(_ sender: Any) {
         let beforeExp = beforeExpTextField.text ?? ""
         let angleExp = angleExpTextField.text ?? ""

         let moduleZ = beforeExp.replacingOccurrences(of: ",", with: ".")
         let angleFi = angleExp.replacingOccurrences(of: ",", with: ".")
         
        let Re = (Double(moduleZ) ?? 0) * cos(degree(Double(angleFi) ?? 0))
        let Im = (Double(moduleZ) ?? 0) * sin(degree(Double(angleFi) ?? 0))
        
         resultLabel.text = String(format: "%.4f", Re) + " + i" + String(format: "%.4f", Im)
    }
    
    @IBAction func didChangeSign(_ sender: UIButton) {
        if signButton.title(for: .normal) == "+"{
            signButton.setTitle("-", for: .normal)
        }else{
            signButton.setTitle("+", for: .normal)
        }
        
    }
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        beforeExpTextField.resignFirstResponder()
        angleExpTextField.resignFirstResponder()
        complexImTextField.resignFirstResponder()
        complexReTextField.resignFirstResponder()
    }

}
