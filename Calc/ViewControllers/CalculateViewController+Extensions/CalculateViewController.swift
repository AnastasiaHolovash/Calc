//
//  CalculateViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 01.12.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var changeFormButton1: ChangeFormButton!
    @IBOutlet weak var changeFormButton2: ChangeFormButton!
    
    @IBOutlet weak var answerView: AnswerView!
    
    @IBOutlet weak var showResultButton: UIButton!
    
    @IBOutlet weak var operationBar: OperationBar!
    
    @IBOutlet weak var expView1: ExpView!
    @IBOutlet weak var complexView1: ComplexView!
    
    @IBOutlet weak var expView2: ExpView!
    @IBOutlet weak var complexView2: ComplexView!
    
    /// number for save
    var firstNumber: ComplexNumber = ComplexNumber(numberType: NumberType.exp, part1: 0.0, part2: 0.0)
    /// number for save
    var secondNumber: ComplexNumber = ComplexNumber(numberType: NumberType.exp, part1: 0.0, part2: 0.0)
    
//    var operationFromHistory: Calculate?
    
    var tabBarC: CustomTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
        buttonsSetup()
        showResultButtonAnimationSetup()
        operationBar.changeSelectedOperation()
        
        guard let tabBar = self.tabBarController as? CustomTabBarController else { return }
        tabBarC = tabBar
        tabBarC.operationDelegate = self
        operationBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Калькулятор"
        
        if let number = tabBarC.transferNumber {
            switch number.numberType {
            case .exp:
                expView1.setNumber(beforeExpNumber: number.part1.simpleRound(decimalPlases: 4), afterExpNumber: number.part2.simpleRound(decimalPlases: 4))
                if expView1.isHidden {
                    changeFormButton1.changeForm()
                }
            case .complex:
                complexView1.setNumber(reNumber: number.part1.simpleRound(decimalPlases: 4), imNumber: number.part2.simpleRound(decimalPlases: 4))
                if complexView1.isHidden {
                    changeFormButton1.changeForm()
                }
            }
            tabBarC.transferNumber = nil
        }
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
    
    
    func buttonsSetup() {
        changeFormButton1.expView = expView1
        changeFormButton1.complexView = complexView1
        changeFormButton2.expView = expView2
        changeFormButton2.complexView = complexView2
        showResultButton.layer.cornerRadius = CGFloat((Double(showResultButton.frame.height) ) / 2.5)
        
    }
    
    @IBAction func didPressChangeForm(_ sender: ChangeFormButton) {
        sender.changeForm()
        recalculate()
    }
    
    
    @IBAction func didPressShowResult(_ sender: UIButton) {
        recalculate()
        expView1.hidekeybourd()
        expView2.hidekeybourd()
        complexView1.hidekeybourd()
        complexView2.hidekeybourd()
        prepareNumbersForHistoryUpdating()
        let operation = Operation.culculate(Calculate(operation: operationBar.curentOperationName, number1: firstNumber, number2: secondNumber))
        History.shared.addOperationToHistory(operation: operation)
    }
    
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        expView1.hidekeybourd()
        expView2.hidekeybourd()
        complexView1.hidekeybourd()
        complexView2.hidekeybourd()
    }
    
}


extension CalculateViewController: OperationDelegate {
    
    func setOperationFromHistory(calculate: Calculate?) {
        if let calculate = calculate {
            setNumbers(number1: calculate.number1, number2: calculate.number2)
            operationBar.curentOperationName = calculate.operation
            operationBar.changeSelectedOperation()
            recalculate()
            self.answerView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
}

extension CalculateViewController: OperationBarDelegate {
    func selectedSwapOperation() {
        prepareNumbersForHistoryUpdating()
        setNumbers(number1: secondNumber, number2: firstNumber)
        recalculate()
    }
    
    func selectedNewOperation() {
        recalculate()
    }
}
