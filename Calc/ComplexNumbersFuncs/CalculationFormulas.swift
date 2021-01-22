//
//  CalculationFormulas.swift
//  Calc
//
//  Created by Головаш Анастасия on 10.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

/**
 Performs the operation of adding two complex numbers.
 
 z1 + z2 = (a1 + a2) + (b1 + b2) ∙ i,
 
 i = √(-1)
*/
func plus(re1: Double, re2: Double, im1: Double, im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (re1 + re2), Im: (im1 + im2))
}


/**
 Performs the operation of subtraction two complex numbers.
 
 z1 - z2 = (a1 - a2) + (b1 - b2) ∙ i,
 
 i = √(-1)
*/
func minus(re1: Double, re2: Double, im1: Double, im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (re1 - re2), Im: (im1 - im2))
}


/**
 Performs the operation of multiplication two complex numbers.
 
 z1 ∙ z2 = (a1∙ a2 - b1 ∙ b2) + (a1 ∙ b2 + a2 ∙ b1) ∙ i,
 
 i = √(-1)
*/
func multiply(re1: Double, re2: Double, im1: Double, im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (re1*re2 - im1*im2), Im: (re1*im2 + re2*im1))
}


/**
 Performs the operation of division two complex numbers.
 
 z1 / z2 = ((a1∙ a2 + b1 ∙ b2) / (a2^2 + b2^2))  +  ((a2 ∙ b1 - a1 ∙ b2) ∙ i  /  (a2^2 + b2^2)),
 
 i = √(-1)
*/
func divide(re1: Double, re2: Double, im1: Double, im2: Double) -> (Re: Double, Im: Double) {
    let re = (re1*re2 + im1*im2) / (pow(re2, 2) + pow(im2, 2))
    let im = (re2*im1 - re1*im2) / (pow(re2, 2) + pow(im2, 2))
    return (Re: re, Im: im)
}


/**
 Converts a complex number of type "Double" to a number in exponential form of type "Double".
 
 z = a + bi
 
 z = |z| ∙ e ^ (i𝝋)
 
 |z| = √(a^2 + b^2)
 
 𝝋 = arg(z)
 
 - Parameter im: The imaginary part of the complex number.
 - Parameter re: The real part of the complex number.

 - Returns: Module of number in exponential form, Angle of number in exponential form in degrees
 */
func complexToExpNumber(im: Double, re: Double) -> (moduleZ: Double, arc: Double) {
    let moduleZ = sqrt(pow(im, 2) + pow(re, 2))
    let im = im == -0 ? 0 : im
    let re = re == -0 ? 0 : re
    let arcFi = atan2(im, re).rad()
    return (moduleZ, arcFi)
}


/**
Converts an exponential number into a complex number.
 
 z = |z| ∙ e ^ (i𝝋)
 
 z = a + bi
 
 a = |z|∙cos(𝝋)
 
 b = |z|∙sin(𝝋)
 
- Parameters:
   -  modulZ: Module of number in exponential form.
   -  arc: Angle of number in exponential form in degrees.
 
- Returns: Complex number.
*/
func expToComplexNumber(modulZ: Double, arc:Double) -> (re:Double, im: Double) {
    let re = modulZ * cos(arc.degree())
    let im = modulZ * sin(arc.degree())
    return (re: re, im: im)
}


/**
 Performs the operation of elevation to the degree complex number.
 
 z^n = |z|^(n) e^(in𝝋),
 
 i = √(-1)
*/
func complexPow(modulZ: Double, arc:Double, n: Double) -> (moduleZ: Double, arc:Double) {
    let modulZ = pow(modulZ, n)
    let arc = arc * n
    return (moduleZ: modulZ, arc: arc)
}


/**
 Performs the operation of root complex number.
 
 n√(z) =n√ |z| ∙(cos((𝝋 + 2𝜋k) / n) + i∙sin((𝝋 + 2𝜋k) / n)),
 
 i = √(-1),
 
 k = 0..n-1.
*/
func complexRoot(modulZ: Double, arc:Double, n: Double) -> [(re: Double, im:Double)] {
    let modulZ = pow(modulZ, 1/n)
    let radArc = arc.degree()
    var result : [(re: Double, im:Double)] = []
    
    for k in 0..<Int(n) {
        let re = modulZ * cos((radArc + 2 * Double.pi * Double(k)) / n)
        let im = modulZ * sin((radArc + 2 * Double.pi * Double(k)) / n)
        result.append((re: re, im: im))
    }
    
    return result
}
