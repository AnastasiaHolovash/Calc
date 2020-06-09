//
//  ViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 27.11.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    //    @IBOutlet weak var beforeExpTextField: UITextField!
//    @IBOutlet weak var angleExpTextField: UITextField!
//    @IBOutlet weak var complexReTextField: UITextField!
//    @IBOutlet weak var complexImTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
//    @IBOutlet weak var modulZSignButton: UIButton!
//    @IBOutlet weak var angleSignButton: UIButton!
//    @IBOutlet weak var signReButton: UIButton!
//    @IBOutlet weak var signImButton: UIButton!
    @IBOutlet weak var convertToComplexButton: UIButton!
    @IBOutlet weak var convertToExpButton: UIButton!
    
    @IBOutlet weak var expView: ExpView!
    @IBOutlet weak var complexView: ComplexView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertToComplexButton.layer.cornerRadius = CGFloat((Double(convertToComplexButton.frame.height) ) / 2.0)
        convertToExpButton.layer.cornerRadius = CGFloat((Double(convertToExpButton.frame.height) ) / 2.0)
        
        }
    
    
//    MARK:- take out to custom Views class
    func hideKeyboard() {
//        beforeExpTextField.resignFirstResponder()
//        angleExpTextField.resignFirstResponder()
//        complexImTextField.resignFirstResponder()
//        complexReTextField.resignFirstResponder()
    }
    
    
    @IBAction func didPressConvertToExp(_ sender: UIButton) {
        
        let re = makeANumber(sign: complexView.reIsPlus, number: complexView.reTextField.text ?? "")
        let im = makeANumber(sign: complexView.imIsPlus, number: complexView.imTextField.text ?? "")
        
        let comlexToExp = complexToExpNumber(Im: im, Re: re)
 
//        let comlexToExp = complexToExp(signIm: signImButton.title(for: .normal), signRe: signReButton.title(for: .normal), complexIm: complexImTextField.text, complexRe: complexReTextField.text)
         
        let attributedStringResultText = attributedStringResult(comlexToExp.0, comlexToExp.1)
        
        resultLabel.attributedText = attributedStringResultText.0
        if attributedStringResultText.1 == true {
            present(alert(), animated: true, completion: nil)
        }
        
        hideKeyboard()
    }
    
//    func convertToComplex(expView: ExpView) -> (Re: Double, Im: Double) {
//
//        let modulZ = makeANumber(sign: expView.beforeExpIsPlus, number: expView.beforeExpTextField.text ?? "")
//        let arc = makeANumber(sign: expView.afterExpIsPlus, number: expView.afterExpTextField.text ?? "")
//
//        return expToComplexNumber(modulZ: modulZ, arc: arc)
//    }
    
    @IBAction func didPressConvertToComplex(_ sender: Any) {

//        let modulZ = makeANumber(sign: expView.beforeExpIsPlus, number: expView.beforeExpTextField.text ?? "")
//        let arc = makeANumber(sign: expView.afterExpIsPlus, number: expView.afterExpTextField.text ?? "")
//        let complex = expToComplexNumber(modulZ: modulZ, arc: arc)
        
        let complex = convertToComplex(expView: expView)
        
        let result = stringResultforComplexForm(complex.Im, complex.Re)
        
        if result.count > 20 {
            resultLabel.text = "No result"
            present(alert(), animated: true, completion: nil)
        } else {
            resultLabel.text = result
        }
        
        hideKeyboard()
    }
    

    
//    @IBAction func didChangeModulZSign(_ sender: UIButton) {
////        changeSign(modulZSignButton)
//    }
//    @IBAction func didChangeAngleSign(_ sender: UIButton) {
////        changeSign(angleSignButton)
//    }
//    @IBAction func didChangeReSign(_ sender: UIButton) {
//        changeSign(signReButton)
//    }
//    @IBAction func didChangeSign(_ sender: UIButton) {
//        changeSign(signImButton)
//    }
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
}
