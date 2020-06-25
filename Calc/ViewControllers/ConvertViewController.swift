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
        let attributedStringResultText = attributedStringResult(comlexToExp.0, comlexToExp.1)
        
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
        
        let complex = convertToComplex(expView: expView)
        let result = stringResultforComplexForm(complex.Im, complex.Re)
        
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
                if numberFromHistory.part1 < 0 {
                    expView.beforeExpSignButtonSetSign(setPlus: false)
                }
                if numberFromHistory.part2 < 0 {
                    expView.afterExpSignButtonSetSign(setPlus: false)
                }
                expView.beforeExpTextField.text = String(abs(numberFromHistory.part1))
                expView.afterExpTextField.text = String(abs(numberFromHistory.part2))
                showComplexResult()
            case .complex:
                if numberFromHistory.part1 < 0 {
                    complexView.reSignButtonSetSign(setPlus: false)
                }
                if numberFromHistory.part2 < 0 {
                    complexView.imSignButtonSetSign(setPlus: false)
                }
                complexView.reTextField.text = String(abs(numberFromHistory.part1))
                complexView.imTextField.text = String(abs(numberFromHistory.part2))
                showExpResult(re: numberFromHistory.part1, im: numberFromHistory.part2)
            }
        }
        
    }
    
}
