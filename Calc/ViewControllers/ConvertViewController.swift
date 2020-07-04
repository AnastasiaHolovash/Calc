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
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var answerView: AnswerView!
    @IBOutlet weak var changeFormButton: ChangeFormButton!
    
    @IBOutlet weak var expView: ExpView!
    @IBOutlet weak var complexView: ComplexView!
    
    var transferNumber: ComplexNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeFormButtonSetup()
        addObserver()
        setupKeyboardToolbar()
        
        guard let tabBarC = self.tabBarController as? CustomTabBarController else { return }
        tabBarC.numberDelegate = self
        
        convertButton.layer.cornerRadius = CGFloat(Double(convertButton.frame.height) / 2.5)
        transferButton.layer.cornerRadius = CGFloat(Double(transferButton.frame.height) / 2.5)
        self.answerView.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
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
    
    
    private func setupKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
                    
        expView.beforeExpTextField.inputAccessoryView = toolbar
        expView.afterExpTextField.inputAccessoryView = toolbar
        complexView.reTextField.inputAccessoryView = toolbar
        complexView.imTextField.inputAccessoryView = toolbar
        }
        
    @objc func doneAction() {
        view.endEditing(true)
    }
    
    @IBAction func didPressTransferButton(_ sender: UIButton) {
        guard let tabBarC = self.tabBarController as? CustomTabBarController else { return }
        tabBarC.transferNumber = transferNumber
        tabBarC.selectedIndex = 1
    }
    
    @IBAction func didPressConvert(_ sender: UIButton) {
        switch changeFormButton.curentForm {
        case .exp:
            let expNumber = makeExpNumber()
            showComplexResult(modulZ: expNumber.modulZ, arc: expNumber.arc)
            
            // For history updating
            let operation = Operation.convert(ComplexNumber(numberType: NumberType.exp, part1: expNumber.modulZ , part2: expNumber.arc))
            History.shared.addOperationToHistory(operation: operation)
            
            expView.hidekeybourd()
            complexView.hidekeybourd()
                
        case .complex:
            let complexNumber = makeComplexNumber()
            showExpResult(re: complexNumber.re, im: complexNumber.im)
            
            // For history updating
            let operation = Operation.convert(ComplexNumber(numberType: NumberType.complex, part1: complexNumber.re , part2: complexNumber.im))
            History.shared.addOperationToHistory(operation: operation)
            
            expView.hidekeybourd()
            complexView.hidekeybourd()
        }
    }
    
    @IBAction func didPressChangeForm(_ sender: ChangeFormButton) {
        sender.changeForm()
        switch changeFormButton.curentForm {
        case .exp:
            let expNumber = makeExpNumber()
            showComplexResult(modulZ: expNumber.modulZ, arc: expNumber.arc)
        case .complex:
            let complexNumber = makeComplexNumber()
            showExpResult(re: complexNumber.re, im: complexNumber.im)
        }
    }
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        expView.hidekeybourd()
        complexView.hidekeybourd()
    }
    
    
    func makeComplexNumber() -> (re: Double, im: Double) {
        let re = makeANumber(sign: complexView.reIsPlus, number: complexView.reTextField.text ?? "")
        let im = makeANumber(sign: complexView.imIsPlus, number: complexView.imTextField.text ?? "")
        return (re: re, im: im)
    }
    

    func makeExpNumber() -> (modulZ: Double, arc: Double) {
        let modulZ = makeANumber(sign: expView.beforeExpIsPlus, number: expView.beforeExpTextField.text ?? "")
        let arc = makeANumber(sign: expView.afterExpIsPlus, number: expView.afterExpTextField.text ?? "")
        return (modulZ: modulZ, arc: arc)
    }
    
    
    func showExpResult(re: Double, im: Double) {
        let exp = complexToExpNumber(Im: im, Re: re)
        transferNumber = ComplexNumber(numberType: .exp, part1: exp.moduleZ, part2: exp.arcFi)
        let result = expNumberToString(moduleZ: exp.moduleZ, arcFi: exp.arcFi)
        let enteredNumber = complexNumberToString(Re: re, Im: im)
        
        answerView.expAnswerLabel.attributedText = attributedStringResult(fullstringResult: result)
        answerView.complexAnswerLabel.text = enteredNumber
    }

    func showComplexResult(modulZ: Double, arc: Double) {
        let complex = expToComplexNumber(modulZ: modulZ, arc: arc)
        transferNumber = ComplexNumber(numberType: .complex, part1: complex.re, part2: complex.im)
        let result = complexNumberToString(Re: complex.re, Im: complex.im, roundTo: 4)
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
                if expView.isHidden {
                    changeFormButton.changeForm()
                }
            case .complex:
                complexView.setNumber(reNumber: numberFromHistory.part1, imNumber: numberFromHistory.part2)
                showExpResult(re: numberFromHistory.part1, im: numberFromHistory.part2)
                if complexView.isHidden {
                    changeFormButton.changeForm()
                }
            }
            self.answerView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
}
