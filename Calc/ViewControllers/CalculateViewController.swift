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
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultLabel2: UILabel!
    @IBOutlet weak var showResultButton: UIButton!
    
    @IBOutlet weak var expView1: ExpView!
    @IBOutlet weak var complexView1: ComplexView!
    
    @IBOutlet weak var expView2: ExpView!
    @IBOutlet weak var complexView2: ComplexView!
    
    /// number for save
    var firstNumber: ComplexNumber = ComplexNumber(numberType: NumberType.exp, part1: 0.0, part2: 0.0)
    /// number for save
    var secondNumber: ComplexNumber = ComplexNumber(numberType: NumberType.exp, part1: 0.0, part2: 0.0)
    var curentOperationName: NameOfOperation = NameOfOperation.plus
    
    var operationFromHistory: Calculate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        buttonsLayerSetup()
        
        // Hides the showResultButton moving it down
        UIView.animate(withDuration: 0) {
            self.showResultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
        }

        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        changeSelectedOperation()
        
        guard let tabBarC = self.tabBarController as? CustomTabBarController else { return }
        tabBarC.operationDelegate = self
    }
    
    func buttonsLayerSetup() {
        // Rounds the corners of the buttons
        changeFormButton1.layer.cornerRadius = CGFloat((Double(changeFormButton1.frame.height) ) / 2.0)
        changeFormButton2.layer.cornerRadius = CGFloat((Double(changeFormButton2.frame.height) ) / 2.0)
        showResultButton.layer.cornerRadius = CGFloat((Double(showResultButton.frame.height) ) / 2.0)
    }

    
    deinit {
        // Stop listening for keyboard show/hide events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

//    MARK:- take out to custom Views class
    ///Hide all keyboards and show the result of calculation
//    func hideKeyboard() {
//        expView1.hidekeybourd()
//        expView2.hidekeybourd()
//        complexView1.hidekeybourd()
//        complexView2.hidekeybourd()
//    }
    
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
    
    /**
    Changes the picture of the selected sign which indicated the operation to the filled picture.
     */
    func changeSelectedOperation() {
        plusButton.setImage(UIImage.init(systemName: "plus.square"), for: .normal)
        minusButton.setImage(UIImage.init(systemName: "minus.square"), for: .normal)
        multiplyButton.setImage(UIImage.init(systemName: "multiply.square"), for: .normal)
        divideButton.setImage(UIImage.init(systemName: "divide.square"), for: .normal)
        
        switch curentOperationName {
        case .plus:
            plusButton.setImage(UIImage.init(systemName: "plus.square.fill"), for: .normal)
        case .minus:
            minusButton.setImage(UIImage.init(systemName: "minus.square.fill"), for: .normal)
        case .multiplication:
            multiplyButton.setImage(UIImage.init(systemName: "multiply.square.fill"), for: .normal)
        case .division:
            divideButton.setImage(UIImage.init(systemName: "divide.square.fill"), for: .normal)
        }

    }
    
    /**
     Reduces both numbers to a complex form.
     - Returns: A real part of the first number, a real part of the second number, an imaginary part of the first number, an imaginary part of the second number.
     */
    func prepareDataForCalc() -> (Re1: Double, Re2: Double, Im1: Double, Im2: Double) {
        
        var Re1: Double = 0.0
        var Im1: Double = 0.0
        
        if !expView1.isHidden {
            let complex = convertToComplex(expView: expView1)
            Re1 = complex.Re
            Im1 = complex.Im
            
            // For history updating
            let modulZ = makeANumber(sign: expView1.beforeExpIsPlus, number: expView1.beforeExpTextField.text ?? "")
            let arc = makeANumber(sign: expView1.afterExpIsPlus, number: expView1.afterExpTextField.text ?? "")
            firstNumber = ComplexNumber(numberType: NumberType.exp, part1: modulZ, part2: arc)
            
        } else {
            Re1 = makeANumber(sign: complexView1.reIsPlus, number: complexView1.reTextField.text ?? "")
            Im1 = makeANumber(sign: complexView1.imIsPlus, number: complexView1.imTextField.text ?? "")
            
            // For history updating
            firstNumber = ComplexNumber(numberType: NumberType.complex, part1: Re1, part2: Im1)
        }
        
        var Re2: Double = 0.0
        var Im2: Double = 0.0
        
        if !expView2.isHidden {
            let complex = convertToComplex(expView: expView2)
            Re2 = complex.Re
            Im2 = complex.Im
            
            // For history updating
            let modulZ = makeANumber(sign: expView2.beforeExpIsPlus, number: expView2.beforeExpTextField.text ?? "")
            let arc = makeANumber(sign: expView2.afterExpIsPlus, number: expView2.afterExpTextField.text ?? "")
            secondNumber = ComplexNumber(numberType: NumberType.exp, part1: modulZ, part2: arc)
            
        } else {
            Re2 = makeANumber(sign: complexView2.reIsPlus, number: complexView2.reTextField.text ?? "")
            Im2 = makeANumber(sign: complexView2.imIsPlus, number: complexView2.imTextField.text ?? "")
            
            // For history updating
            secondNumber = ComplexNumber(numberType: NumberType.complex, part1: Re2, part2: Im2)
        }
        
        return (Re1: Re1, Re2: Re2, Im1: Im1, Im2: Im2)
    }
        
    
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
    
    /// Prepare data for calculetion, calculete and show recult of adding two complex numbers. Recult presents in complex and exponential forms.
    func showPlusRecult() {
        let data = prepareDataForCalc()
        let result = plus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
        
//        operationName = .plus
    }
    /// Prepare data for calculetion, calculete and show recult of subtraction two complex numbers. Recult presents in complex and exponential forms.
    func showMinusRecult() {
        let data = prepareDataForCalc()
        let result = minus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
        
//        operationName = .minus
    }
    /// Prepare data for calculetion, calculete and show recult of multiplication two complex numbers. Recult presents in complex and exponential forms.
    func showMultiplyRecult() {
        let data = prepareDataForCalc()
        let result = multiply(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
        
//        operationName = .multiplication
    }
    /// Prepare data for calculetion, calculete and show recult of division two complex numbers. Recult presents in complex and exponential forms.
    func showDivideRecult() {
        let data = prepareDataForCalc()
        let result = divide(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
        
//        operationName = .division
    }
    
    /**
     Recalculate.
     
        1. Checks which mathematical operation is selected.
        2. Recalculate.

     */
    func recalculate() {
        switch curentOperationName {
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
    
    
    @objc func keyboardWillChange(notification: Notification){
        
        if notification.name.rawValue == "UIKeyboardWillShowNotification"{
            UIView.animate(withDuration: 2) {
                self.showResultButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }else{
            UIView.animate(withDuration: 2) {
                self.showResultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
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

    @IBAction func selectedPlusOperation(_ sender: UIButton) {
        curentOperationName = .plus
        changeSelectedOperation()
        showPlusRecult()
    }
    
    @IBAction func selectedMinusOperation(_ sender: UIButton) {
        curentOperationName = .minus
        changeSelectedOperation()
        showMinusRecult()
    }
    @IBAction func selectedMultiplyOperation(_ sender: UIButton) {
        curentOperationName = .multiplication
        changeSelectedOperation()
        showMultiplyRecult()
    }
    @IBAction func selectedDivideOperation(_ sender: UIButton) {
        curentOperationName = .division
        changeSelectedOperation()
        showDivideRecult()
    }
    
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
        let operation = Operation.culculate(Calculate(operation: curentOperationName, number1: firstNumber, number2: secondNumber))
        History.shared.addOperationToHistory(operation: operation)
    }
    
}

extension CalculateViewController: OperationDelegate {
    
    func setOperationFromHistory(calculate: Calculate?) {
        if let calculate = calculate {
            switch calculate.number1.numberType {
            case .exp:
                expView1.setNumber(beforeExpNumber: calculate.number1.part1, afterExpNumber: calculate.number1.part2)
            case .complex:
                complexView1.setNumber(reNumber: calculate.number1.part1, imNumber: calculate.number1.part2)
            }
            switch calculate.number2.numberType {
            case .exp:
                expView2.setNumber(beforeExpNumber: calculate.number2.part1, afterExpNumber: calculate.number2.part2)
            case .complex:
                complexView2.setNumber(reNumber: calculate.number2.part1, imNumber: calculate.number2.part2)
            }
            curentOperationName = calculate.operation
            changeSelectedOperation()
            recalculate()
        }
    }
    
}
