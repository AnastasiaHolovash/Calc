//
//  ViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 27.11.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController {

    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var answerView: AnswerView!
    @IBOutlet weak var changeFormButton: ChangeFormButton!
    
    @IBOutlet weak var expView: ExpView!
    @IBOutlet weak var complexView: ComplexView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeFormButtonSetup()
        addObserver()
        
        guard let tabBarC = self.tabBarController as? CustomTabBarController else { return }
        tabBarC.numberDelegate = self
        
        convertButton.layer.cornerRadius = CGFloat((Double(convertButton.frame.height) ) / 2.5)
    }
    
    func addObserver() {
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        // Stop listening for keyboard show/hide events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        //  MARK:- movement animation
        if notification.name.rawValue == "UIKeyboardWillShowNotification"{
            UIView.animate(withDuration: 1) {
                self.answerView.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.answerView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
    }

    
    func changeFormButtonSetup() {
        changeFormButton.expView = expView
        changeFormButton.complexView = complexView
    }
    
        
    @IBAction func didPressConvert(_ sender: UIButton) {
        switch changeFormButton.curentForm {
        case .exp:
            let modulZ = makeANumber(sign: expView.beforeExpIsPlus, number: expView.beforeExpTextField.text ?? "")
            let arc = makeANumber(sign: expView.afterExpIsPlus, number: expView.afterExpTextField.text ?? "")
            showComplexResult(modulZ: modulZ, arc: arc)
            
            // For history updating
            let operation = Operation.convert(ComplexNumber(numberType: NumberType.exp, part1: modulZ , part2: arc))
            History.shared.addOperationToHistory(operation: operation)
            
            expView.hidekeybourd()
            complexView.hidekeybourd()
            
        case .complex:
            let re = makeANumber(sign: complexView.reIsPlus, number: complexView.reTextField.text ?? "")
            let im = makeANumber(sign: complexView.imIsPlus, number: complexView.imTextField.text ?? "")
            showExpResult(re: re, im: im)
            
            // For history updating
            let operation = Operation.convert(ComplexNumber(numberType: NumberType.complex, part1: re , part2: im))
            History.shared.addOperationToHistory(operation: operation)
            
            expView.hidekeybourd()
            complexView.hidekeybourd()
        }
    }
    
    @IBAction func didPressChangeForm(_ sender: ChangeFormButton) {
        sender.changeForm()
    }
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        expView.hidekeybourd()
        complexView.hidekeybourd()
    }
    
    
    func showExpResult(re: Double, im: Double) {
        let exp = complexToExpNumber(Im: im, Re: re)
        let result = expNumberToString(moduleZ: exp.moduleZ, arcFi: exp.arcFi)
        let enteredNumber = complexNumberToString(Re: re, Im: im)
        
        answerView.expAnswerLabel.attributedText = attributedStringResult(fullstringResult: result)
        answerView.complexAnswerLabel.text = enteredNumber
    }

    func showComplexResult(modulZ: Double, arc: Double) {
        let complex = expToComplexNumber(modulZ: modulZ, arc: arc)
        let result = complexNumberToString(Re: complex.Re, Im: complex.Im, roundTo: 4)
        let enteredNumber = expNumberToString(moduleZ: modulZ, arcFi: arc)
        
        answerView.expAnswerLabel.attributedText = attributedStringResult(fullstringResult: enteredNumber)
        answerView.complexAnswerLabel.text = result
        
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
                showComplexResult(modulZ: numberFromHistory.part1, arc: numberFromHistory.part2)
            case .complex:
                complexView.setNumber(reNumber: numberFromHistory.part1, imNumber: numberFromHistory.part2)
                showExpResult(re: numberFromHistory.part1, im: numberFromHistory.part2)
            }
        }
    }
    
}
