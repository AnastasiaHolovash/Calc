//
//  PrepareAndShowResultExtension.swift
//  Calc
//
//  Created by Головаш Анастасия on 28.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension CalculateViewController: ChangeSignBottomsDelegate {
    
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
    
    
    /**
     Reduces both numbers to a complex form.
     - Returns: A real part of the first number, a real part of the second number, an imaginary part of the first number, an imaginary part of the second number.
     */
    func prepareDataForCalc() -> (Re1: Double, Re2: Double, Im1: Double, Im2: Double) {
        
        var complex1 = (re: 0.0, im: 0.0)
        
        if !expView1.isHidden {
            let exp1 = makeExpNumber1()
            complex1 = expToComplexNumber(modulZ: exp1.modulZ, arc: exp1.arc)
        } else {
            complex1 = makeComplexNumber1()
        }
        
        var complex2 = (re: 0.0, im: 0.0)
        
        if !expView2.isHidden {
            let exp2 = makeExpNumber2()
            complex2 = expToComplexNumber(modulZ: exp2.modulZ, arc: exp2.arc)
        } else {
            complex2 = makeComplexNumber2()
        }
        return (Re1: complex1.re, Re2: complex2.re, Im1: complex1.im, Im2: complex2.im)
        
    }
    
    
    func makeComplexNumber1() -> (re: Double, im: Double) {
        let re = makeANumber(sign: complexView1.reIsPlus, number: complexView1.reTextField.text ?? "")
        let im = makeANumber(sign: complexView1.imIsPlus, number: complexView1.imTextField.text ?? "")
        return (re: re, im: im)
    }

    func makeComplexNumber2() -> (re: Double, im: Double) {
        let re = makeANumber(sign: complexView2.reIsPlus, number: complexView2.reTextField.text ?? "")
        let im = makeANumber(sign: complexView2.imIsPlus, number: complexView2.imTextField.text ?? "")
        return (re: re, im: im)
    }

    func makeExpNumber1() -> (modulZ: Double, arc: Double) {
        let modulZ = makeANumber(sign: expView1.beforeExpIsPlus, number: expView1.beforeExpTextField.text ?? "")
        let arc = makeANumber(sign: expView1.afterExpIsPlus, number: expView1.afterExpTextField.text ?? "")
        return (modulZ: modulZ, arc: arc)
    }

    func makeExpNumber2() -> (modulZ: Double, arc: Double) {
        let modulZ = makeANumber(sign: expView2.beforeExpIsPlus, number: expView2.beforeExpTextField.text ?? "")
        let arc = makeANumber(sign: expView2.afterExpIsPlus, number: expView2.afterExpTextField.text ?? "")
        return (modulZ: modulZ, arc: arc)
    }

    
    /// Prepare data for calculetion, calculete and show recult of adding two complex numbers. Recult presents in complex and exponential forms.
    func showPlusRecult() {
        let data = prepareDataForCalc()
        let result = plus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        answerView.complexAnswerLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of subtraction two complex numbers. Recult presents in complex and exponential forms.
    func showMinusRecult() {
        let data = prepareDataForCalc()
        let result = minus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        answerView.complexAnswerLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of multiplication two complex numbers. Recult presents in complex and exponential forms.
    func showMultiplyRecult() {
        let data = prepareDataForCalc()
        let result = multiply(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        answerView.complexAnswerLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of division two complex numbers. Recult presents in complex and exponential forms.
    func showDivideRecult() {
        let data = prepareDataForCalc()
        let result = divide(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        answerView.complexAnswerLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
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
        let stringResult = expNumberToString(moduleZ: resulsWithExp.moduleZ, arcFi: resulsWithExp.arcFi)
        
        if stringResult == "Невизначеність" {
            answerView.expAnswerLabel.text = stringResult
        } else {
            answerView.expAnswerLabel.attributedText = attributedStringResult(fullstringResult: stringResult)
        }
    }
    
}
