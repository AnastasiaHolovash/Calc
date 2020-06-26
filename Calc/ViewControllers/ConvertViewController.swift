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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertToComplexButton.layer.cornerRadius = CGFloat((Double(convertToComplexButton.frame.height) ) / 2.0)
        convertToExpButton.layer.cornerRadius = CGFloat((Double(convertToExpButton.frame.height) ) / 2.0)
        
        guard let tabBarC = self.tabBarController as? CustomTabBarController else { return }
        tabBarC.numberDelegate = self
        
    }
    
    func showExpResult(re: Double, im: Double) {
        
        let comlexToExp = complexToExpNumber(Im: im, Re: re)
        let attributedStringResultText = attributedStringResult(moduleZ: comlexToExp.0, arcFi: comlexToExp.1, roundTo: 4)
        
        if attributedStringResultText.1 == true {
            present(alert(), animated: true, completion: nil)
        } else {
            resultLabel.attributedText = attributedStringResultText.0
        }
    }
    
    @IBAction func didPressConvertToExp(_ sender: UIButton) {
        
        let re = makeANumber(sign: complexView.reIsPlus, number: complexView.reTextField.text ?? "")
        let im = makeANumber(sign: complexView.imIsPlus, number: complexView.imTextField.text ?? "")
        showExpResult(re: re, im: im)
        // For history updating
        let operation = Operation.convert(ComplexNumber(numberType: NumberType.complex, part1: re , part2: im))
        History.shared.addOperationToHistory(operation: operation)
    }
    
    func showComplexResult() {
        // MARK:- don`t transmit expView
        let complex = convertToComplex(expView: expView)
        let result = complexNumberToString(Re: complex.Re, Im: complex.Im, roundTo: 4)
        
        if result.count > 20 {
            resultLabel.text = "No result"
            present(alert(), animated: true, completion: nil)
        } else {
            resultLabel.text = result
        }
    }
    
    @IBAction func didPressConvertToComplex(_ sender: Any) {
        
        showComplexResult()
        
        // For history updating
        let modulZ = makeANumber(sign: expView.beforeExpIsPlus, number: expView.beforeExpTextField.text ?? "")
        let arc = makeANumber(sign: expView.afterExpIsPlus, number: expView.afterExpTextField.text ?? "")
        
        let operation = Operation.convert(ComplexNumber(numberType: NumberType.exp, part1: modulZ , part2: arc))
        History.shared.addOperationToHistory(operation: operation)
    }
    

    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        
    }
    
}


extension ConvertViewController: NumberDelegate {
    
    func setNumberFromHistory(number: ComplexNumber?) {
        expView.clearView()
        complexView.clearView()
        if let numberFromHistory = number {
            switch numberFromHistory.numberType {
            case .exp:
                expView.setNumber(beforeExpNumber: numberFromHistory.part1, afterExpNumber: numberFromHistory.part2)
                showComplexResult()
            case .complex:
                complexView.setNumber(reNumber: numberFromHistory.part1, imNumber: numberFromHistory.part2)
                showExpResult(re: numberFromHistory.part1, im: numberFromHistory.part2)
            }
        }
    }
    
}
