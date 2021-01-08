//
//  OperationBar.swift
//  Calc
//
//  Created by Головаш Анастасия on 28.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

protocol OperationBarDelegate {
    func selectedNewOperation()
    func selectedSwapOperation()
}

class OperationBar: UIStackView {
    
    var delegate: OperationBarDelegate?
    
    //  Operation Sign Buttons
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var powButton: UIButton!
    @IBOutlet weak var rootButton: UIButton!
    @IBOutlet weak var swapButton: UIButton!
    
    
    public var curentOperationName: NameOfOperation = NameOfOperation.plus
    
    /**
    Changes the picture of the selected sign which indicated the operation to the filled picture.
     */
    func changeSelectedOperation() {
        plusButton.setImage(UIImage.init(systemName: "plus.square"), for: .normal)
        minusButton.setImage(UIImage.init(systemName: "minus.square"), for: .normal)
        multiplyButton.setImage(UIImage.init(systemName: "multiply.square"), for: .normal)
        divideButton.setImage(UIImage.init(systemName: "divide.square"), for: .normal)
        powButton.setImage(UIImage(named: "z^n-square"), for: .normal)
        rootButton.setImage(UIImage(named: "root-square"), for: .normal)
        
//        plusButton.tintColor = .label
//        minusButton.tintColor = .label
//        multiplyButton.tintColor = .label
//        divideButton.tintColor = .label
        
        switch curentOperationName {
        case .plus:
            plusButton.setImage(UIImage.init(named: "plus-square-fill"), for: .normal)
//            plusButton.tintColor = .systemIndigo
        case .minus:
            minusButton.setImage(UIImage.init(named: "minus-square-fill"), for: .normal)
//            minusButton.tintColor = .systemIndigo
        case .multiplication:
            multiplyButton.setImage(UIImage.init(named: "multiply-square-fill"), for: .normal)
//            multiplyButton.tintColor = .systemIndigo
        case .division:
            divideButton.setImage(UIImage.init(named: "divide-square-fill"), for: .normal)
//            divideButton.tintColor = .systemIndigo
        case .pow:
            powButton.setImage(UIImage(named: "z^n-square-fill"), for: .normal)
//            powButton.tintColor = .systemIndigo
        case .root:
            rootButton.setImage(UIImage(named: "root-square-fill"), for: .normal)
//            rootButton.tintColor = .systemIndigo
        }
    }
    
    @IBAction func wasSelectedNewOperation(_ sender: UIButton) {
        switch sender {
        case plusButton:
            curentOperationName = .plus
        case minusButton:
            curentOperationName = .minus
        case multiplyButton:
            curentOperationName = .multiplication
        case divideButton:
            curentOperationName = .division
        case powButton:
            curentOperationName = .pow
        case rootButton:
            curentOperationName = .root
        case swapButton:
            self.delegate?.selectedSwapOperation()
        default:
            print("Error")
        }
        changeSelectedOperation()
        self.delegate?.selectedNewOperation()
    }
}
