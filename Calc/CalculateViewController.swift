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

    @IBOutlet weak var expView1: UIView!
    @IBOutlet weak var complexView1: UIView!
    @IBOutlet weak var expView2: UIView!
    @IBOutlet weak var complexView2: UIView!
//  Sidn Buttons
    @IBOutlet weak var modulZSignButton1: UIButton!
    @IBOutlet weak var modulZSignButton2: UIButton!
    @IBOutlet weak var angleSignButton1: UIButton!
    @IBOutlet weak var angleSignButton2: UIButton!
    @IBOutlet weak var signReButton1: UIButton!
    @IBOutlet weak var signReButton2: UIButton!
    @IBOutlet weak var signImButton1: UIButton!
    @IBOutlet weak var signImButton2: UIButton!
//  Text Fields
    @IBOutlet weak var beforeExpTextField1: UITextField!
    @IBOutlet weak var beforeExpTextField2: UITextField!
    @IBOutlet weak var angleExpTextField1: UITextField!
    @IBOutlet weak var angleExpTextField2: UITextField!
    @IBOutlet weak var complexReTextField1: UITextField!
    @IBOutlet weak var complexReTextField2: UITextField!
    @IBOutlet weak var complexImTextField1: UITextField!
    @IBOutlet weak var complexImTextField2: UITextField!
//  Operation Sign Buttons
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultLabel2: UILabel!
    @IBOutlet weak var cleanButton1: UIButton!
    @IBOutlet weak var cleanButton2: UIButton!
    @IBOutlet weak var showResultButton: UIButton!
    
    
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
    }
    
    func buttonsLayerSetup() {
        // Rounds the corners of the buttons
        changeFormButton1.layer.cornerRadius = CGFloat((Double(changeFormButton1.frame.height) ) / 2.0)
        changeFormButton2.layer.cornerRadius = CGFloat((Double(changeFormButton2.frame.height) ) / 2.0)
        cleanButton1.layer.cornerRadius = CGFloat((Double(cleanButton1.frame.height) ) / 2.0)
        cleanButton2.layer.cornerRadius = CGFloat((Double(cleanButton2.frame.height) ) / 2.0)
        showResultButton.layer.cornerRadius = CGFloat((Double(cleanButton2.frame.height) ) / 2.0)
    }

    
    deinit {
        // Stop listening for keyboard show/hide events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    ///Hide all keyboards and show the result of calculation
    func hideKeyboard() {
        beforeExpTextField1.resignFirstResponder()
        beforeExpTextField2.resignFirstResponder()
        angleExpTextField1.resignFirstResponder()
        angleExpTextField2.resignFirstResponder()
        complexReTextField1.resignFirstResponder()
        complexReTextField2.resignFirstResponder()
        complexImTextField1.resignFirstResponder()
        complexImTextField2.resignFirstResponder()
        showRecult()
    }
    
    /**
     Change view with exponential form representation to complex and conversely.
     - Parameters:
        - button: Button which will be pressed to change view.
        - expViev: View with exponential form representation.
        - complexView: View with complex form representation.
     */
    func changeForm(button: UIButton, expViev: UIView, complexView: UIView) {
        if button.title(for: .normal) == "Complex form" {
            button.setTitle("Exp form", for: .normal)
            expViev.isHidden = true
            complexView.isHidden = false
        } else {
            button.setTitle("Complex form", for: .normal)
            complexView.isHidden = true
            expViev.isHidden = false
        }
    }
    
    /**
    Changes the picture of the selected sign which indicated the operation to the filled picture.
     - Parameters:
        - button: Selected Button with sign which indicated mathematical operation.
        - imageName: Name of  filled picture with sign which indicated mathematical operation.
     */
    func selectedOperation(button: UIButton, imageName: String) {
        plusButton.setImage(UIImage.init(systemName: "plus.square"), for: .normal)
        minusButton.setImage(UIImage.init(systemName: "minus.square"), for: .normal)
        multiplyButton.setImage(UIImage.init(systemName: "multiply.square"), for: .normal)
        divideButton.setImage(UIImage.init(systemName: "divide.square"), for: .normal)
        button.setImage(UIImage.init(systemName: imageName), for: .normal)
    }
    
    /**
     Reduces both numbers to a complex form.
     - Returns: A real part of the first number, a real part of the second number, an imaginary part of the first number, an imaginary part of the second number.
     */
    func prepareDataForCalc() -> (Re1: Double, Re2: Double, Im1: Double, Im2: Double) {
        
        for expView in [expView1, expView2] {
            if let expView = expView {
                if expView.isHidden {
//                    let complexnumber =
                }
            }
            
        }
        
        
        
        
        let firstNumberInComplexForm = allDataToComlexForm(modulZSignButton1, angleSignButton1, beforeExpTextField1, angleExpTextField1, signReButton1, signImButton1, complexReTextField1, complexImTextField1, expView1)
        
         let secondNumberInComplexForm = allDataToComlexForm(modulZSignButton2, angleSignButton2, beforeExpTextField2, angleExpTextField2, signReButton2, signImButton2, complexReTextField2, complexImTextField2, expView2)
        
        return (Re1: firstNumberInComplexForm.Re, Re2: secondNumberInComplexForm.Re, Im1: firstNumberInComplexForm.Im, Im2: secondNumberInComplexForm.Im)
    }
    // MARK: - todo func that
    func allDataToComlexForm(_ modulZSignButton: UIButton, _ angleSignButton: UIButton, _ beforeExpTextField: UITextField, _ angleExpTextField: UITextField, _ signReButton: UIButton, _ signImButton: UIButton, _ complexReTextField: UITextField, _ complexImTextField: UITextField, _ expView: UIView!) ->  (Re: Double, Im: Double){
                var re: Double?
                var im: Double?
                if expView.isHidden == false {
        //            print("-------EXP--------")
                    let result = expToComlex(signModulZ: modulZSignButton.title(for: .normal), signArc: angleSignButton.title(for: .normal), modulZ:  beforeExpTextField.text, arc: angleExpTextField.text)
                    re = result.Re
                    im = result.Im
                } else {
                    re = Double((signReButton.title(for: .normal) ?? "") + (complexReTextField.text ?? ""))
                    im = Double((signImButton.title(for: .normal) ?? "") + (complexImTextField.text ?? ""))
                }
                guard let re1 = re,
                      let im1 = im else { return (Re: 0, Im: 0)}
        
        return (Re: re1, Im: im1)
    }
    
    
    /**
     Presents recult of calculation in exponential form.
     - Parameter result:Recult of calculation in complex form.
        - Im: The imaginary part of the complex number.
        - Re:The real part of the complex number.
     */
    func showResulsWithExp(result: (Im: Double, Re: Double)) {
        /// 'result' in exponential form of type "Double".
        let resulsWithExp = doubleComplexToExp(Im: result.Im, Re: result.Re)
        /// An appearance of complex number in exponential form.
        let attributedStringResultText = attributedStringResult(resulsWithExp.moduleZ, resulsWithExp.arcFi)
        resultLabel2.attributedText = attributedStringResultText.0
        if attributedStringResultText.1 == true {
            present(alert(), animated: true, completion: nil)
        }
    }
    
    /// Prepare data for calculetion, calculete and show recult of adding two complex numbers. Recult presents in complex and exponential forms.
    func showPlusRecult() {
        let data = prepareDataForCalc()
        let result = plus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = stringResultforComplexForm(result.Im, result.Re)
        showResulsWithExp(result: result)
    }
    /// Prepare data for calculetion, calculete and show recult of subtraction two complex numbers. Recult presents in complex and exponential forms.
    func showMinusRecult() {
        let data = prepareDataForCalc()
        let result = minus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = stringResultforComplexForm(result.Im, result.Re)
        showResulsWithExp(result: result)
    }
    /// Prepare data for calculetion, calculete and show recult of multiplication two complex numbers. Recult presents in complex and exponential forms.
    func showMultiplyRecult() {
        let data = prepareDataForCalc()
        let result = multiply(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = stringResultforComplexForm(result.Im, result.Re)
        showResulsWithExp(result: result)
    }
    /// Prepare data for calculetion, calculete and show recult of division two complex numbers. Recult presents in complex and exponential forms.
    func showDivideRecult() {
        let data = prepareDataForCalc()
        let result = divide(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = stringResultforComplexForm(result.Im, result.Re)
        showResulsWithExp(result: result)
    }
    
    /**
     Recalculate.
     
        1. Checks which button with the mathematical operation is selected.
        2. Recalculate.
        3. Returns 'true' if nothing was selected and 'false' in other case.
     */
    func recalculate() -> Bool{
        
        switch plusButton.currentImage {
        case UIImage.init(systemName: "plus.square.fill"):
            showPlusRecult()
            return false
        case UIImage.init(systemName: "minus.square.fill"):
            showMinusRecult()
            return false
        case UIImage.init(systemName: "multiply.square.fill"):
            showMultiplyRecult()
            return false
        case UIImage.init(systemName: "divide.square.fill"):
            showDivideRecult()
            return false
        default:
            return true
        }
        
//        if plusButton.currentImage == UIImage.init(systemName: "plus.square.fill"){
//            showPlusRecult()
//            return false
//        }else if minusButton.currentImage == UIImage.init(systemName: "minus.square.fill"){
//            showMinusRecult()
//            return false
//        }else if multiplyButton.currentImage == UIImage.init(systemName: "multiply.square.fill"){
//            showMultiplyRecult()
//            return false
//        }else if divideButton.currentImage == UIImage.init(systemName: "divide.square.fill"){
//            showDivideRecult()
//            return false
//        }else {
//            return true
//        }
    }
    
    /**
     Shows Recult
     */
    func showRecult() {
        if recalculate(){
            present(alert2(), animated: true, completion: nil)
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
        _ = recalculate()
    }
    @IBAction func changeFormAction2(_ sender: UIButton) {
        changeForm(button: changeFormButton2, expViev: expView2, complexView: complexView2)
        _ = recalculate()
    }

    @IBAction func didChangeModulZSign1(_ sender: UIButton) {
        changeSign(modulZSignButton1)
        _ = recalculate()
    }
    @IBAction func didChangeModulZSign2(_ sender: UIButton) {
        changeSign(modulZSignButton2)
        _ = recalculate()
    }
    @IBAction func didChangeAngleSign1(_ sender: UIButton) {
        changeSign(angleSignButton1)
        _ = recalculate()
    }
    @IBAction func didChangeAngleSign2(_ sender: UIButton) {
        changeSign(angleSignButton2)
        _ = recalculate()
    }
    @IBAction func didChangeReSign1(_ sender: UIButton) {
        changeSign(signReButton1)
        _ = recalculate()
    }
    @IBAction func didChangeReSign2(_ sender: UIButton) {
        changeSign(signReButton2)
        _ = recalculate()
    }
    @IBAction func didChangeImSign1(_ sender: UIButton) {
        changeSign(signImButton1)
        _ = recalculate()
    }
    @IBAction func didChangeImSign2(_ sender: UIButton) {
        changeSign(signImButton2)
        _ = recalculate()
    }
    

    @IBAction func selectedPlusOperation(_ sender: UIButton) {
        selectedOperation(button: plusButton, imageName: "plus.square.fill")
        showPlusRecult()
    }
    
    @IBAction func selectedMinusOperation(_ sender: UIButton) {
        selectedOperation(button: minusButton, imageName: "minus.square.fill")
        showMinusRecult()
    }
    @IBAction func selectedMultiplyOperation(_ sender: UIButton) {
        selectedOperation(button: multiplyButton, imageName: "multiply.square.fill")
        showMultiplyRecult()
    }
    @IBAction func selectedDivideOperation(_ sender: UIButton) {
        selectedOperation(button: divideButton, imageName: "divide.square.fill")
        showDivideRecult()
    }
    
    
    
    @IBAction func didPressClean1(_ sender: UIButton) {
        if expView1.isHidden == false{
            beforeExpTextField1.text = ""
            beforeExpTextField1.placeholder = "0"
            angleExpTextField1.text = ""
            angleExpTextField1.placeholder = "0"
        }else{
            complexReTextField1.text = ""
            complexReTextField1.placeholder = "0"
            complexImTextField1.text = ""
            complexImTextField1.placeholder = "0"
        }
        if recalculate(){}
    }
    @IBAction func didPressClean2(_ sender: UIButton) {
        if expView2.isHidden == false{
            beforeExpTextField2.text = ""
            beforeExpTextField2.placeholder = "0"
            angleExpTextField2.text = ""
            angleExpTextField2.placeholder = "0"
        }else{
            complexReTextField2.text = ""
            complexReTextField2.placeholder = "0"
            complexImTextField2.text = ""
            complexImTextField2.placeholder = "0"
        }
        if recalculate(){}
    }
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
    
    @IBAction func didPressShowResult(_ sender: UIButton) {
        hideKeyboard()
//        showResultButton.isHidden = true
    }
    
}
