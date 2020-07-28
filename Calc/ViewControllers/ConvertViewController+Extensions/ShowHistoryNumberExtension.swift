//
//  ShowHistoryNumberExtension.swift
//  Calc
//
//  Created by Головаш Анастасия on 29.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension ConvertViewController: NumberDelegate {
    
    func setNumberFromHistory(number: ComplexNumber?) {
        expView.clearView()
        complexView.clearView()
        if let numberFromHistory = number {
            switch numberFromHistory.numberType {
            case .exp:
                expView.setNumber(beforeExpNumber: numberFromHistory.part1, afterExpNumber: numberFromHistory.part2)
                showComplexResult(modulZ: numberFromHistory.part1, arc: numberFromHistory.part2)
                if expView.isHidden {
                    changeFormButton.changeForm()
                }
            case .complex:
                complexView.setNumber(reNumber: numberFromHistory.part1, imNumber: numberFromHistory.part2)
                showExpResult(re: numberFromHistory.part1, im: numberFromHistory.part2)
                if complexView.isHidden {
                    changeFormButton.changeForm()
                }
            }
            self.answerView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
}

