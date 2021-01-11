//
//  Double+Extensions.swift
//  Calc
//
//  Created by Головаш Анастасия on 27.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension Double {
    
    
    /**
    Rounds number.
    - Parameter decimalPlases: The required number of digits after the floating point.
    - Returns: Rounded number.
    */
    func simpleRound(decimalPlases: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlases))
        return (self * divisor).rounded() / divisor
    }
    
    
    /**
    Rounds number.
    - Parameter decimalPlases: The required number of digits after the floating point.
    - Returns: Number of type Int if the number is an integer or type Double  in other case.
    */
    func smartRound(decimalPlases: Int) -> Any {
        let divisor = pow(10.0, Double(decimalPlases))
        let rounded = (self * divisor).rounded() / divisor
        
        if rounded.remainder(dividingBy: 1) == 0 {
            
            if (rounded > Double(Int.max)) || (rounded < Double(Int.min)){
                return rounded
            } else {
                return Int(rounded)
            }
            
        } else {
            return rounded
        }
    }
    
    
    ///Сonverts radians to degrees.
    func rad() -> Double {
        return self * 180 / .pi
    }


    ///Сonverts degrees to radians.
    func degree() -> Double {
        return self * .pi / 180
    }
}
