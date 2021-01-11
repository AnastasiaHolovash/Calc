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
        case .pow:
            showPowRecult()
        case .root:
            showRootRecult()
        }
    }
    
    
    /**
     Reduces both numbers to a complex form.
     - Returns: A real part of the first number, a real part of the second number, an imaginary part of the first number, an imaginary part of the second number.
     */
    func prepareComplexDataForCalc() -> (Re1: Double, Re2: Double, Im1: Double, Im2: Double) {
        
        var complex1 = (re: 0.0, im: 0.0)
        
        if !expView1.isHidden {
            let exp1 = makeExpNumber1()
            complex1 = expToComplexNumber(modulZ: exp1.moduleZ, arc: exp1.arc)
        } else {
            complex1 = makeComplexNumber1()
        }
        
        var complex2 = (re: 0.0, im: 0.0)
        
        if !expView2.isHidden {
            let exp2 = makeExpNumber2()
            complex2 = expToComplexNumber(modulZ: exp2.moduleZ, arc: exp2.arc)
        } else {
            complex2 = makeComplexNumber2()
        }
        return (Re1: complex1.re, Re2: complex2.re, Im1: complex1.im, Im2: complex2.im)
    }
    
    func prepareExpDataForCalc() -> (moduleZ: Double, arc: Double) {

        var complex = (re: 0.0, im: 0.0)
        
        if !expView1.isHidden {
            let exp = makeExpNumber1()
            complex = expToComplexNumber(modulZ: exp.moduleZ, arc: exp.arc)
        } else {
            complex = makeComplexNumber1()
        }
        
        let exp = complexToExpNumber(Im: complex.im, Re: complex.re)
        
        return (moduleZ: exp.moduleZ, arc: exp.arc)
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

    func makeExpNumber1() -> (moduleZ: Double, arc: Double) {
        let moduleZ = makeANumber(sign: expView1.beforeExpIsPlus, number: expView1.beforeExpTextField.text ?? "")
        let arc = makeANumber(sign: expView1.afterExpIsPlus, number: expView1.afterExpTextField.text ?? "")
        return (moduleZ: moduleZ, arc: arc)
    }

    func makeExpNumber2() -> (moduleZ: Double, arc: Double) {
        let modulZ = makeANumber(sign: expView2.beforeExpIsPlus, number: expView2.beforeExpTextField.text ?? "")
        let arc = makeANumber(sign: expView2.afterExpIsPlus, number: expView2.afterExpTextField.text ?? "")
        return (moduleZ: modulZ, arc: arc)
    }

    
    /// Prepare data for calculetion, calculete and show recult of adding two complex numbers. Recult presents in complex and exponential forms.
    func showPlusRecult() {
        let data = prepareComplexDataForCalc()
        let result = plus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        answerView.complexAnswerLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        let resulsWithExp = complexToExpNumber(Im: result.Im, Re: result.Re)
        showResulsWithExp(result: resulsWithExp)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of subtraction two complex numbers. Recult presents in complex and exponential forms.
    func showMinusRecult() {
        let data = prepareComplexDataForCalc()
        let result = minus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        answerView.complexAnswerLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        let resulsWithExp = complexToExpNumber(Im: result.Im, Re: result.Re)
        showResulsWithExp(result: resulsWithExp)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of multiplication two complex numbers. Recult presents in complex and exponential forms.
    func showMultiplyRecult() {
        let data = prepareComplexDataForCalc()
        let result = multiply(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        answerView.complexAnswerLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        let resulsWithExp = complexToExpNumber(Im: result.Im, Re: result.Re)
        showResulsWithExp(result: resulsWithExp)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of division two complex numbers. Recult presents in complex and exponential forms.
    func showDivideRecult() {
        let data = prepareComplexDataForCalc()
        let result = divide(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        answerView.complexAnswerLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        let resulsWithExp = complexToExpNumber(Im: result.Im, Re: result.Re)
        showResulsWithExp(result: resulsWithExp)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of pow operation. Recult presents in complex and exponential forms.
    func showPowRecult() {
        let data = prepareExpDataForCalc()
        let result = complexPow(modulZ: data.moduleZ, arc: data.arc, n: Double(nView.textField.text ?? "1") ?? 0.0)

        // Conversion to complex and back is needed for correct display of arc
        let complex = expToComplexNumber(modulZ: result.moduleZ, arc: result.arc)
        answerView.complexAnswerLabel.text = complexNumberToString(Re: complex.re, Im: complex.im, roundTo: 4)
        showResulsWithExp(result: complexToExpNumber(Im: complex.im, Re: complex.re))
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of pow operation. Recult presents in complex and exponential forms.
    func showRootRecult() {
        let data = prepareExpDataForCalc()
        let result = complexRoot(modulZ: data.moduleZ, arc: data.arc, n: Double(nView.textField.text ?? "1") ?? 0.0)

        print(result)
        // Conversion to complex and back is needed for correct display of arc
//        let complex = expToComplexNumber(modulZ: result.moduleZ, arc: result.arc)
//        answerView.complexAnswerLabel.text = complexNumberToString(Re: complex.re, Im: complex.im, roundTo: 4)
//        showResulsWithExp(result: complexToExpNumber(Im: complex.im, Re: complex.re))
    }
    
    
    /**
     Presents recult of calculation in exponential form.
     - Parameter result:Recult of calculation in complex form.
        - Im: The imaginary part of the complex number.
        - Re:The real part of the complex number.
     */
    func showResulsWithExp(result: (moduleZ: Double, arc: Double)) {
        
        /// An appearance of complex number in exponential form.
        let stringResult = expNumberToString(moduleZ: result.moduleZ, arcFi: result.arc)
        
        if stringResult == NSLocalizedString("Uncertainty", comment: "It is impossible to calculate the exact value") {
            answerView.expAnswerLabel.text = stringResult
        } else {
            answerView.expAnswerLabel.attributedText = attributedStringResult(fullstringResult: stringResult)
        }
    }
}
