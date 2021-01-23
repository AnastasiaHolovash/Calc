//
//  PrepareAndShowResultExtension.swift
//  Calc
//
//  Created by Головаш Анастасия on 29.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension ConvertViewController {
    
    
    func makeComplexNumber() -> (re: Double, im: Double) {
        let re = makeANumber(sign: complexView.reIsPlus, number: complexView.reTextField.text ?? "")
        let im = makeANumber(sign: complexView.imIsPlus, number: complexView.imTextField.text ?? "")
        return (re: re, im: im)
    }
    

    func makeExpNumber() -> (modulZ: Double, arc: Double) {
        let modulZ = makeANumber(sign: expView.beforeExpIsPlus, number: expView.beforeExpTextField.text ?? "")
        let arc = makeANumber(sign: expView.afterExpIsPlus, number: expView.afterExpTextField.text ?? "")
        return (modulZ: modulZ, arc: arc)
    }
    
    
    func showExpResult(re: Double, im: Double) {
        let exp = complexToExpNumber(im: im, re: re)
        transferNumber = ComplexNumber(numberType: .exp, part1: exp.moduleZ, part2: exp.arc)
        let result = expNumberToString(moduleZ: exp.moduleZ, arcFi: exp.arc)
        let enteredNumber = complexNumberToString(Re: re, Im: im)
        
        if result == NSLocalizedString("Uncertainty", comment: "It is impossible to calculate the exact value") {
            answerView.expAnswerLabel.text = result
        } else {
            answerView.expAnswerLabel.attributedText = attributedStringResult(fullstringResult: result)
        }
        answerView.complexAnswerLabel.text = enteredNumber
    }

    
    func showComplexResult(modulZ: Double, arc: Double) {
        let complex = expToComplexNumber(modulZ: modulZ, arc: arc)
        transferNumber = ComplexNumber(numberType: .complex, part1: complex.re, part2: complex.im)
        let result = complexNumberToString(Re: complex.re, Im: complex.im, roundTo: 4)
        let enteredNumber = expNumberToString(moduleZ: modulZ, arcFi: arc)
        
        if enteredNumber == NSLocalizedString("Uncertainty", comment: "It is impossible to calculate the exact value") {
            answerView.expAnswerLabel.text = enteredNumber
        } else {
            answerView.expAnswerLabel.attributedText = attributedStringResult(fullstringResult: enteredNumber)
        }
        answerView.complexAnswerLabel.text = result
    }
    
    
}
