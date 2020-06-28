//
//  PrepareAndShowResultExtension.swift
//  Calc
//
//  Created by Головаш Анастасия on 28.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension CalculateViewController {
    
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

    
    /// Prepare data for calculetion, calculete and show recult of adding two complex numbers. Recult presents in complex and exponential forms.
    func showPlusRecult() {
        let data = prepareDataForCalc()
        let result = plus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of subtraction two complex numbers. Recult presents in complex and exponential forms.
    func showMinusRecult() {
        let data = prepareDataForCalc()
        let result = minus(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of multiplication two complex numbers. Recult presents in complex and exponential forms.
    func showMultiplyRecult() {
        let data = prepareDataForCalc()
        let result = multiply(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
        showResulsWithExp(result: result)
    }
    
    
    /// Prepare data for calculetion, calculete and show recult of division two complex numbers. Recult presents in complex and exponential forms.
    func showDivideRecult() {
        let data = prepareDataForCalc()
        let result = divide(Re1: data.Re1, Re2: data.Re2, Im1: data.Im1, Im2: data.Im2)
        resultLabel.text = complexNumberToString(Re: result.Re, Im: result.Im, roundTo: 4)
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
        let attributedStringResultText = attributedStringResult_(moduleZ: resulsWithExp.moduleZ, arcFi: resulsWithExp.arcFi, roundTo: 4)
        resultLabel2.attributedText = attributedStringResultText.0
        if attributedStringResultText.1 == true {
            present(alert(), animated: true, completion: nil)
        }
    }
    
}
