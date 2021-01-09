//
//  ShowHistoryOperationExtension.swift
//  Calc
//
//  Created by Головаш Анастасия on 04.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension CalculateViewController {
    
    func prepareNumbersForHistoryUpdating() {
        if !expView1.isHidden {
            let exp1 = makeExpNumber1()
            firstNumber = ComplexNumber(numberType: NumberType.exp, part1: exp1.moduleZ, part2: exp1.arc)
        } else {
            let complex1 = makeComplexNumber1()
            firstNumber = ComplexNumber(numberType: NumberType.complex, part1: complex1.re, part2: complex1.im)
        }
        if !expView2.isHidden {
            let exp2 = makeExpNumber2()
            secondNumber = ComplexNumber(numberType: NumberType.exp, part1: exp2.moduleZ, part2: exp2.arc)
        } else {
            let complex2 = makeComplexNumber2()
            secondNumber = ComplexNumber(numberType: NumberType.complex, part1: complex2.re, part2: complex2.im)
        }
    }
    
    
    func setNumbers(number1: ComplexNumber, number2: ComplexNumber) {
        switch number1.numberType {
        case .exp:
            expView1.setNumber(beforeExpNumber: number1.part1, afterExpNumber: number1.part2)
            if expView1.isHidden {
                changeFormButton1.changeForm()
            }
        case .complex:
            complexView1.setNumber(reNumber: number1.part1, imNumber: number1.part2)
            if complexView1.isHidden {
                changeFormButton1.changeForm()
            }
        }
        switch number2.numberType {
        case .exp:
            expView2.setNumber(beforeExpNumber: number2.part1, afterExpNumber: number2.part2)
            if expView2.isHidden {
                changeFormButton2.changeForm()
            }
        case .complex:
            complexView2.setNumber(reNumber: number2.part1, imNumber: number2.part2)
            if complexView2.isHidden {
                changeFormButton2.changeForm()
            }
        }
    }
}
