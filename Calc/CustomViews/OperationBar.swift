//
//  OperationBar.swift
//  Calc
//
//  Created by Головаш Анастасия on 28.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

protocol OperationBarDelegate {
    func selectedNewSimpleOperation()
    func selectedSwapOperation()
    func selectedPowOrRootOperation()
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
        
        switch curentOperationName {
        case .plus:
            plusButton.setImage(UIImage.init(named: "plus-square-fill"), for: .normal)
            swapButton.isUserInteractionEnabled = true
            swapButton.tintColor = .label
            self.delegate?.selectedNewSimpleOperation()
        
        case .minus:
            minusButton.setImage(UIImage.init(named: "minus-square-fill"), for: .normal)
            swapButton.isUserInteractionEnabled = true
            swapButton.tintColor = .label
            self.delegate?.selectedNewSimpleOperation()
        
        case .multiplication:
            multiplyButton.setImage(UIImage.init(named: "multiply-square-fill"), for: .normal)
            swapButton.isUserInteractionEnabled = true
            swapButton.tintColor = .label
            self.delegate?.selectedNewSimpleOperation()
        
        case .division:
            divideButton.setImage(UIImage.init(named: "divide-square-fill"), for: .normal)
            swapButton.isUserInteractionEnabled = true
            swapButton.tintColor = .label
            self.delegate?.selectedNewSimpleOperation()
        
        case .pow:
            powButton.setImage(UIImage(named: "z^n-square-fill"), for: .normal)
            swapButton.isUserInteractionEnabled = false
            swapButton.tintColor = .gray
            self.delegate?.selectedPowOrRootOperation()
            
        case .root:
            rootButton.setImage(UIImage(named: "root-square-fill"), for: .normal)
            swapButton.isUserInteractionEnabled = false
            swapButton.tintColor = .gray
            self.delegate?.selectedPowOrRootOperation()
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
    }
}
