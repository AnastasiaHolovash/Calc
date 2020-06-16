//
//  Operation.swift
//  Calc
//
//  Created by Головаш Анастасия on 15.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

enum Operation {
    case culculate(Calculate)
    case convert(ComplexNumber)
}

extension Operation: Codable, Equatable {
    
    //MARK:- Equatable
    static func == (lhs: Operation, rhs: Operation) -> Bool {
        switch (lhs, rhs) {
        case (let .culculate(lhsCalculate), let .culculate(rhsCalculate)):
            return lhsCalculate == rhsCalculate
        case (let .convert(lhsComplexNumber), let .convert(rhsComplexNumber)):
        return lhsComplexNumber == rhsComplexNumber
        default:
            return false
        }
    }
    
    //MARK:- Codable
    enum Key: CodingKey {
        case rawValue
        case associatedValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            let culculate = try container.decode(Calculate.self, forKey: .associatedValue)
            self = .culculate(culculate)
        case 1:
            let convert = try container.decode(ComplexNumber.self, forKey: .associatedValue)
            self = .convert(convert)
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .culculate(let culculate):
            try container.encode(0, forKey: .rawValue)
            try container.encode(culculate, forKey: .associatedValue)
        case .convert(let convert):
            try container.encode(1, forKey: .rawValue)
            try container.encode(convert, forKey: .associatedValue)
        }
    }
    
    
}


enum NameOfOperation: String, Codable {
    case plus
    case minus
    case multiplication
    case division
}

enum NumberType: String, Codable {
    case exp
    case complex
}



struct Calculate: Codable, Equatable {
    
    let operation: NameOfOperation
    let number1: ComplexNumber
    let number2: ComplexNumber
    
    static func == (lhs: Calculate, rhs: Calculate) -> Bool {
        return (lhs.operation, lhs.number1, lhs.number2) == (rhs.operation, rhs.number1, rhs.number2)
    }
}


struct ComplexNumber: Codable, Equatable {
    let numberType: NumberType
    let part1: Double
    let part2: Double
}