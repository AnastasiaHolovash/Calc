//
//  CalculateViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 01.12.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var changeFormButton1: UIButton!
    @IBOutlet weak var changeFormButton2: UIButton!
    
    @IBOutlet weak var anwerView: AnswerView!
    //    @IBOutlet weak var resultLabel: UILabel!
//    @IBOutlet weak var resultLabel2: UILabel!
    
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
    
    var operationFromHistory: Calculate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
        buttonsLayerSetup()
        showResultButtonAnimationSetup()
        operationBar.changeSelectedOperation()
        
        guard let tabBarC = self.tabBarController as? CustomTabBarController else { return }
        tabBarC.operationDelegate = self
        operationBar.delegate = self
        
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
    
    
    func buttonsLayerSetup() {
        // Rounds the corners of the buttons
        changeFormButton1.layer.cornerRadius = CGFloat((Double(changeFormButton1.frame.height) ) / 2.5)
        changeFormButton2.layer.cornerRadius = CGFloat((Double(changeFormButton2.frame.height) ) / 2.5)
        showResultButton.layer.cornerRadius = CGFloat((Double(showResultButton.frame.height) ) / 2.5)
        
    }
    
    
    @IBAction func changeFormAction1(_ sender: UIButton) {
        changeForm(button: sender, expViev: expView1, complexView: complexView1)
        recalculate()
    }
    
    
    @IBAction func changeFormAction2(_ sender: UIButton) {
        changeForm(button: sender, expViev: expView2, complexView: complexView2)
        recalculate()
    }
    
    
    @IBAction func didPressShowResult(_ sender: UIButton) {
        recalculate()
        expView1.hidekeybourd()
        expView2.hidekeybourd()
        complexView1.hidekeybourd()
        complexView2.hidekeybourd()
//        anwerView.show()
        let operation = Operation.culculate(Calculate(operation: operationBar.curentOperationName, number1: firstNumber, number2: secondNumber))
        History.shared.addOperationToHistory(operation: operation)
    }
    
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        expView1.hidekeybourd()
        expView2.hidekeybourd()
        complexView1.hidekeybourd()
        complexView2.hidekeybourd()
//        anwerView.show()
    }
    
}

extension CalculateViewController: OperationDelegate {
    
    func setOperationFromHistory(calculate: Calculate?) {
        if let calculate = calculate {
            switch calculate.number1.numberType {
            case .exp:
                expView1.setNumber(beforeExpNumber: calculate.number1.part1, afterExpNumber: calculate.number1.part2)
                if expView1.isHidden {
                    changeForm(button: changeFormButton1, expViev: expView1, complexView: complexView1)
                }
            case .complex:
                complexView1.setNumber(reNumber: calculate.number1.part1, imNumber: calculate.number1.part2)
                if complexView1.isHidden {
                    changeForm(button: changeFormButton1, expViev: expView1, complexView: complexView1)
                }
            }
            switch calculate.number2.numberType {
            case .exp:
                expView2.setNumber(beforeExpNumber: calculate.number2.part1, afterExpNumber: calculate.number2.part2)
                if expView2.isHidden {
                    changeForm(button: changeFormButton2, expViev: expView2, complexView: complexView2)
                }
            case .complex:
                complexView2.setNumber(reNumber: calculate.number2.part1, imNumber: calculate.number2.part2)
                if complexView2.isHidden {
                    changeForm(button: changeFormButton2, expViev: expView2, complexView: complexView2)
                }
            }
            operationBar.curentOperationName = calculate.operation
            operationBar.changeSelectedOperation()
            recalculate()
        }
    }
    
}

extension CalculateViewController: OperationBarDelegate {
    func selectedNewOperation() {
        recalculate()
    }
}
