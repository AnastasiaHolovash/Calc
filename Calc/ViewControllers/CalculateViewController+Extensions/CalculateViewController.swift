//
//  CalculateViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 01.12.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var changeFormButton1: UIButton!
    @IBOutlet weak var changeFormButton2: UIButton!

//  Operation Sign Buttons
//    @IBOutlet weak var plusButton: UIButton!
//    @IBOutlet weak var minusButton: UIButton!
//    @IBOutlet weak var multiplyButton: UIButton!
//    @IBOutlet weak var divideButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultLabel2: UILabel!
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
    
//    var curentOperationName: NameOfOperation = NameOfOperation.plus
    
    var operationFromHistory: Calculate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        buttonsLayerSetup()
        showResultButtonAnimationSetup()
        operationBar.changeSelectedOperation()
        guard let tabBarC = self.tabBarController as? CustomTabBarController else { return }
        tabBarC.operationDelegate = self
        operationBar.delegate = self
    }
    
    deinit {
        // Stop listening for keyboard show/hide events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func buttonsLayerSetup() {
        // Rounds the corners of the buttons
        changeFormButton1.layer.cornerRadius = CGFloat((Double(changeFormButton1.frame.height) ) / 2.0)
        changeFormButton2.layer.cornerRadius = CGFloat((Double(changeFormButton2.frame.height) ) / 2.0)
        showResultButton.layer.cornerRadius = CGFloat((Double(showResultButton.frame.height) ) / 2.0)
    }
    
    /**
     Change view with exponential form representation to complex and conversely.
     - Parameters:
        - button: Button which will be pressed to change view.
        - expViev: View with exponential form representation.
        - complexView: View with complex form representation.
     */
    func changeForm(button: UIButton, expViev: UIView, complexView: UIView) {
        if button.title(for: .normal) == "Комплексна форма" {
            button.setTitle("Експоненційна форма", for: .normal)
            expViev.isHidden = true
            complexView.isHidden = false
        } else {
            button.setTitle("Комплексна форма", for: .normal)
            complexView.isHidden = true
            expViev.isHidden = false
        }
    }
    
//    MARK:- Operation Bar
    /**
    Changes the picture of the selected sign which indicated the operation to the filled picture.
     */
//    func changeSelectedOperation() {
//        plusButton.setImage(UIImage.init(systemName: "plus.square"), for: .normal)
//        minusButton.setImage(UIImage.init(systemName: "minus.square"), for: .normal)
//        multiplyButton.setImage(UIImage.init(systemName: "multiply.square"), for: .normal)
//        divideButton.setImage(UIImage.init(systemName: "divide.square"), for: .normal)
//
//        switch curentOperationName {
//        case .plus:
//            plusButton.setImage(UIImage.init(systemName: "plus.square.fill"), for: .normal)
//        case .minus:
//            minusButton.setImage(UIImage.init(systemName: "minus.square.fill"), for: .normal)
//        case .multiplication:
//            multiplyButton.setImage(UIImage.init(systemName: "multiply.square.fill"), for: .normal)
//        case .division:
//            divideButton.setImage(UIImage.init(systemName: "divide.square.fill"), for: .normal)
//        }
//
//    }
    
    /**
     Presents recult of calculation in exponential form.
     - Parameter result:Recult of calculation in complex form.
        - Im: The imaginary part of the complex number.
        - Re:The real part of the complex number.
     */
    func showResulsWithExp(result: (Im: Double, Re: Double)) {
        /// 'result' in exponential form of type "Double".
        let resulsWithExp = complexToExpNumber(Im: result.Im, Re: result.Re)
        /// An appearance of complex number in exponential form.
        let attributedStringResultText = attributedStringResult_(moduleZ: resulsWithExp.moduleZ, arcFi: resulsWithExp.arcFi, roundTo: 4)
        resultLabel2.attributedText = attributedStringResultText.0
        if attributedStringResultText.1 == true {
            present(alert(), animated: true, completion: nil)
        }
    }
    
    /**
     Recalculate.
        1. Checks which mathematical operation is selected.
        2. Recalculate.
     */
    func recalculate() {
        switch operationBar.curentOperationName {
        case .plus:
            showPlusRecult()
        case .minus:
            showMinusRecult()
        case .multiplication:
            showMultiplyRecult()
        case .division:
            showDivideRecult()
        }
    }
    
    
    @IBAction func changeFormAction1(_ sender: UIButton) {
        changeForm(button: changeFormButton1, expViev: expView1, complexView: complexView1)
        recalculate()
    }
    @IBAction func changeFormAction2(_ sender: UIButton) {
        changeForm(button: changeFormButton2, expViev: expView2, complexView: complexView2)
        recalculate()
    }
    
    //    MARK:- Operation Bar
//
//    @IBAction func selectedPlusOperation(_ sender: UIButton) {
//        curentOperationName = .plus
//        changeSelectedOperation()
//        showPlusRecult()
//    }
//
//    @IBAction func selectedMinusOperation(_ sender: UIButton) {
//        curentOperationName = .minus
//        changeSelectedOperation()
//        showMinusRecult()
//    }
//    @IBAction func selectedMultiplyOperation(_ sender: UIButton) {
//        curentOperationName = .multiplication
//        changeSelectedOperation()
//        showMultiplyRecult()
//    }
//    @IBAction func selectedDivideOperation(_ sender: UIButton) {
//        curentOperationName = .division
//        changeSelectedOperation()
//        showDivideRecult()
//    }
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        expView1.hidekeybourd()
        expView2.hidekeybourd()
        complexView1.hidekeybourd()
        complexView2.hidekeybourd()
    }
    
    @IBAction func didPressShowResult(_ sender: UIButton) {
        recalculate()
        expView1.hidekeybourd()
        expView2.hidekeybourd()
        complexView1.hidekeybourd()
        complexView2.hidekeybourd()
        let operation = Operation.culculate(Calculate(operation: operationBar.curentOperationName, number1: firstNumber, number2: secondNumber))
        History.shared.addOperationToHistory(operation: operation)
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
