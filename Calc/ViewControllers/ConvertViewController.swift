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
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var convertToComplexButton: UIButton!
    @IBOutlet weak var convertToExpButton: UIButton!
    
    @IBOutlet weak var expView: ExpView!
    @IBOutlet weak var complexView: ComplexView!
    
    var number: ComplexNumber?
        
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
         
        let attributedStringResultText = attributedStringResult(comlexToExp.0, comlexToExp.1)
        
        resultLabel.attributedText = attributedStringResultText.0
        if attributedStringResultText.1 == true {
            present(alert(), animated: true, completion: nil)
        }
        
        hideKeyboard()
        
        // For history updating
        let operation = Operation.convert(ComplexNumber(numberType: NumberType.complex, part1: re , part2: im))
        History.shared.addOperationToHistory(operation: operation)
    }
    
    
    @IBAction func didPressConvertToComplex(_ sender: Any) {
        
        let complex = convertToComplex(expView: expView)
        
        let result = stringResultforComplexForm(complex.Im, complex.Re)
        
        if result.count > 20 {
            resultLabel.text = "No result"
            present(alert(), animated: true, completion: nil)
        } else {
            resultLabel.text = result
        }
        
        hideKeyboard()
        
        // For history updating
        let modulZ = makeANumber(sign: expView.beforeExpIsPlus, number: expView.beforeExpTextField.text ?? "")
        let arc = makeANumber(sign: expView.afterExpIsPlus, number: expView.afterExpTextField.text ?? "")
        
        let operation = Operation.convert(ComplexNumber(numberType: NumberType.exp, part1: modulZ , part2: arc))
        History.shared.addOperationToHistory(operation: operation)
    }
    

    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
    
//    func updateHistory(operation: Operation) {
//        var allOperations = History.shared.resultHistory
//        print(allOperations)
//        allOperations.insert(operation, at: 0)
//        History.shared.resultHistory = allOperations
//    }
    
}
