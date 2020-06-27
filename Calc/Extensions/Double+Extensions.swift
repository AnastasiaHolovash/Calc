//
//  Double+Extensions.swift
//  Calc
//
//  Created by Головаш Анастасия on 27.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension Double {
    func simpleRound(decimalPlases: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlases))
        return (self * divisor).rounded() / divisor
    }
    func smartRound(decimalPlases: Int) -> Any {
        let divisor = pow(10.0, Double(decimalPlases))
        let rounded = (self * divisor).rounded() / divisor
        if rounded.remainder(dividingBy: 1) == 0 {
            return Int(rounded)
        } else {
            return rounded
        }
    }
}
