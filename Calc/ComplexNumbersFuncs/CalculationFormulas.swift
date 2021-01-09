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
func plus(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (Re1 + Re2), Im: (Im1 + Im2))
}


/**
 Performs the operation of subtraction two complex numbers.
 
 z1 - z2 = (a1 - a2) + (b1 - b2) ∙ i,
 
 i = √(-1)
*/
func minus(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (Re1 - Re2), Im: (Im1 - Im2))
}


/**
 Performs the operation of multiplication two complex numbers.
 
 z1 ∙ z2 = (a1∙ a2 - b1 ∙ b2) + (a1 ∙ b2 + a2 ∙ b1) ∙ i,
 
 i = √(-1)
*/
func multiply(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    return (Re: (Re1*Re2 - Im1*Im2), Im: (Re1*Im2 + Re2*Im1))
}


/**
 Performs the operation of division two complex numbers.
 
 z1 / z2 = ((a1∙ a2 + b1 ∙ b2) / (a2^2 + b2^2))  +  ((a2 ∙ b1 - a1 ∙ b2) ∙ i  /  (a2^2 + b2^2)),
 
 i = √(-1)
*/
func divide(Re1: Double, Re2: Double, Im1: Double, Im2: Double) -> (Re: Double, Im: Double) {
    let re = (Re1*Re2 + Im1*Im2) / (pow(Re2, 2) + pow(Im2, 2))
    let im = (Re2*Im1 - Re1*Im2) / (pow(Re2, 2) + pow(Im2, 2))
    return (Re: re, Im: im)
}


/**
 Converts a complex number of type "Double" to a number in exponential form of type "Double".
 
 z = a + bi
 
 z = |z| ∙ e ^ (i𝝋)
 
 |z| = √(a^2 + b^2)
 
 𝝋 = arg(z)
 
 - Parameter Im: The imaginary part of the complex number.
 - Parameter Re: The real part of the complex number.

 - Returns: Module of number in exponential form, Angle of number in exponential form in degrees
 */
func complexToExpNumber(Im: Double, Re: Double) -> (moduleZ: Double, arc: Double) {
    let moduleZ = sqrt(pow(Im, 2) + pow(Re, 2))
    let im = Im == -0 ? 0 : Im
    let re = Re == -0 ? 0 : Re
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
    let Re = modulZ * cos(arc.degree())
    let Im = modulZ * sin(arc.degree())
    return (re: Re, im: Im)
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
