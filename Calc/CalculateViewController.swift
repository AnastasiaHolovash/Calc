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
//  Operation Sidn Buttons
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultLabel2: UILabel!
    @IBOutlet weak var cleanButton1: UIButton!
    @IBOutlet weak var cleanButton2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeFormButton1.layer.cornerRadius = CGFloat((Double(changeFormButton1.frame.height) ) / 2.0)
        changeFormButton2.layer.cornerRadius = CGFloat((Double(changeFormButton2.frame.height) ) / 2.0)
        cleanButton1.layer.cornerRadius = CGFloat((Double(cleanButton1.frame.height) ) / 2.0)
        cleanButton2.layer.cornerRadius = CGFloat((Double(cleanButton2.frame.height) ) / 2.0)

    }
    
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
    
    
    func selectedOperation(button: UIButton, imageName: String) {
        plusButton.setImage(UIImage.init(systemName: "plus.square"), for: .normal)
        minusButton.setImage(UIImage.init(systemName: "minus.square"), for: .normal)
        multiplyButton.setImage(UIImage.init(systemName: "multiply.square"), for: .normal)
        divideButton.setImage(UIImage.init(systemName: "divide.square"), for: .normal)
        button.setImage(UIImage.init(systemName: imageName), for: .normal)
    }
    
    func prepareDataForCalc() -> (Re1: Double, Re2: Double, Im1: Double, Im2: Double) {
        let firstNumberInComplexForm = allDataToComlexForm(modulZSignButton1, angleSignButton1, beforeExpTextField1, angleExpTextField1, signReButton1, signImButton1, complexReTextField1, complexImTextField1, expView1)
        
         let secondNumberInComplexForm = allDataToComlexForm(modulZSignButton2, angleSignButton2, beforeExpTextField2, angleExpTextField2, signReButton2, signImButton2, complexReTextField2, complexImTextField2, expView2)
        
        return (Re1: firstNumberInComplexForm.Re, Re2: secondNumberInComplexForm.Re, Im1: firstNumberInComplexForm.Im, Im2: secondNumberInComplexForm.Im)
    }
    
    func showResulsWithExp(result: (Im: Double, Re: Double)) {
        let resulsWithExp = doubleComplexToExp(Im: result.Im, Re: result.Re)
        let attributedStringResultText = attributedStringResult(resulsWithExp.moduleZ, resulsWithExp.arcFi)
        resultLabel2.attributedText = attributedStringResultText.0
        if attributedStringResultText.1 == true {
            present(alert(), animated: true, completion: nil)
        }
    }
    
    func showPlusRecult() {
        let data = prepareDataForCalc()
        let result = plus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = stringResultforComplexForm(result.Im, result.Re)
        showResulsWithExp(result: result)
        
//        let resulsWithExp = doubleComplexToExp(Im: result.Im, Re: result.Re)
//        let attributedStringResultText = attributedStringResult(resulsWithExp.moduleZ, resulsWithExp.arcFi)
//        resultLabel2.attributedText = attributedStringResultText.0
//        if attributedStringResultText.1 == true {
//            present(alert(), animated: true, completion: nil)
//        }
    }
    
    func showMinusRecult() {
        let data = prepareDataForCalc()
        let result = minus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = stringResultforComplexForm(result.Im, result.Re)
        showResulsWithExp(result: result)
    }
    
    func showMultiplyRecult() {
        let data = prepareDataForCalc()
        let result = multiply(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = stringResultforComplexForm(result.Im, result.Re)
        showResulsWithExp(result: result)
    }
    
    func showDivideRecult() {
        let data = prepareDataForCalc()
        let result = divide(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = stringResultforComplexForm(result.Im, result.Re)
        showResulsWithExp(result: result)
    }
    
    func showRecult() {
        if plusButton.currentImage == UIImage.init(systemName: "plus.square.fill"){
            print("selected + ")
            showPlusRecult()
        }
        if minusButton.currentImage == UIImage.init(systemName: "minus.square.fill"){
            print("selected - ")
            showMinusRecult()
        }
        if multiplyButton.currentImage == UIImage.init(systemName: "multiply.square.fill"){
            print("selected * ")
            showMultiplyRecult()
        }
        if divideButton.currentImage == UIImage.init(systemName: "divide.square.fill"){
            print("selected / ")
            showDivideRecult()
        }
    }
    


    
    @IBAction func changeFormAction1(_ sender: UIButton) {
        changeForm(button: changeFormButton1, expViev: expView1, complexView: complexView1)
    }
    @IBAction func changeFormAction2(_ sender: UIButton) {
        changeForm(button: changeFormButton2, expViev: expView2, complexView: complexView2)
    }

    @IBAction func didChangeModulZSign1(_ sender: UIButton) {
        changeSign(modulZSignButton1)
    }
    @IBAction func didChangeModulZSign2(_ sender: UIButton) {
        changeSign(modulZSignButton2)
    }
    @IBAction func didChangeAngleSign1(_ sender: UIButton) {
        changeSign(angleSignButton1)
    }
    @IBAction func didChangeAngleSign2(_ sender: UIButton) {
        changeSign(angleSignButton2)
    }
    @IBAction func didChangeReSign1(_ sender: UIButton) {
        changeSign(signReButton1)
    }
    @IBAction func didChangeReSign2(_ sender: UIButton) {
        changeSign(signReButton2)
    }
    @IBAction func didChangeImSign1(_ sender: UIButton) {
        changeSign(signImButton1)
    }
    @IBAction func didChangeImSign2(_ sender: UIButton) {
        changeSign(signImButton2)
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
    
    
    @IBAction func didPressEqual(_ sender: UIButton) {
        print(plusButton.isSelected)
//        if plusButton.currentImage == UIImage.init(systemName: "plus.square.fill"){
//            print("selected + ")
//            showPlusRecult()
//        }
//        if minusButton.currentImage == UIImage.init(systemName: "minus.square.fill"){
//            print("selected - ")
//            showMinusRecult()
//        }
//        if multiplyButton.currentImage == UIImage.init(systemName: "multiply.square.fill"){
//            print("selected * ")
//            showMultiplyRecult()
//        }
//        if divideButton.currentImage == UIImage.init(systemName: "divide.square.fill"){
//            print("selected / ")
//            showDivideRecult()
//        }
        hideKeyboard()
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
    }
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
    
}
