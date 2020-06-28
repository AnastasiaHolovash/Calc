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
}

class OperationBar: UIStackView {
    
    var delegate: OperationBarDelegate?
    
    //  Operation Sign Buttons
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    public var curentOperationName: NameOfOperation = NameOfOperation.plus
    
    /**
    Changes the picture of the selected sign which indicated the operation to the filled picture.
     */
    func changeSelectedOperation() {
        plusButton.setImage(UIImage.init(systemName: "plus.square"), for: .normal)
        minusButton.setImage(UIImage.init(systemName: "minus.square"), for: .normal)
        multiplyButton.setImage(UIImage.init(systemName: "multiply.square"), for: .normal)
        divideButton.setImage(UIImage.init(systemName: "divide.square"), for: .normal)
        
        switch curentOperationName {
        case .plus:
            plusButton.setImage(UIImage.init(systemName: "plus.square.fill"), for: .normal)
        case .minus:
            minusButton.setImage(UIImage.init(systemName: "minus.square.fill"), for: .normal)
        case .multiplication:
            multiplyButton.setImage(UIImage.init(systemName: "multiply.square.fill"), for: .normal)
        case .division:
            divideButton.setImage(UIImage.init(systemName: "divide.square.fill"), for: .normal)
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
        default:
            print("Error")
        }
        changeSelectedOperation()
        self.delegate?.selectedNewOperation()
    }
}
