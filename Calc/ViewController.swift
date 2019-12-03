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
    @IBOutlet weak var signImButton: UIButton!
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
    
    
    @IBAction func didPressConvertToExp(_ sender: UIButton) {
 
        let comlexToExp = complexToExp(signIm: signImButton.title(for: .normal), signRe: signReButton.title(for: .normal), complexIm: complexImTextField.text, complexRe: complexReTextField.text)
         
        let attributedStringResultText = attributedStringResult(comlexToExp.0, comlexToExp.1)
        
        resultLabel.attributedText = attributedStringResultText.0
        if attributedStringResultText.1 == true {
            present(alert(), animated: true, completion: nil)
        }
        
        hideKeyboard()
    }
    
    @IBAction func didPressConvertToComplex(_ sender: Any) {
        
        let beforeExp = (modulZSignButton.title(for: .normal) ?? "") + (beforeExpTextField.text ?? "")
        let angleExp = (angleSignButton.title(for: .normal) ?? "") + (angleExpTextField.text ?? "")

        let moduleZ = beforeExp.replacingOccurrences(of: ",", with: ".")
        let angleFi = angleExp.replacingOccurrences(of: ",", with: ".")
         
        let Re = (Double(moduleZ) ?? 0) * cos(degree(Double(angleFi) ?? 0))
        let Im = (Double(moduleZ) ?? 0) * sin(degree(Double(angleFi) ?? 0))
        
        let result: String
        if Im < 0 {
            result = String(format: "%.4f", Re) + " - i" + String(format: "%.4f", -Im)
        } else {
            result = String(format: "%.4f", Re) + " + i" + String(format: "%.4f", Im)
        }
        if result.count > 20 {
            resultLabel.text = "No result"
            present(alert(), animated: true, completion: nil)
        } else {
            resultLabel.text = result
        }
        
        hideKeyboard()
    }
    

    
    @IBAction func didChangeModulZSign(_ sender: UIButton) {
        changeSign(modulZSignButton)
    }
    @IBAction func didChangeAngleSign(_ sender: UIButton) {
        changeSign(angleSignButton)
    }
    @IBAction func didChangeReSign(_ sender: UIButton) {
        changeSign(signReButton)
    }
    @IBAction func didChangeSign(_ sender: UIButton) {
        changeSign(signImButton)
    }
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
}
