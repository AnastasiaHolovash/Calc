//
//  TableViewCell.swift
//  Calc
//
//  Created by Головаш Анастасия on 17.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var viewWithShadow: UIView!
    @IBOutlet weak var numberLabel1: UILabel!
    @IBOutlet weak var numberLabel2: UILabel!
    @IBOutlet weak var operationSignLabel: UILabel!
    @IBOutlet weak var operationTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 0.945, green: 0.949, blue: 0.965, alpha: 1)
        viewWithShadow.layer.cornerRadius = 20
        viewWithShadow.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        viewWithShadow.layer.shadowOpacity = 1
        viewWithShadow.layer.shadowOffset = CGSize(width: 0, height: 1)
        viewWithShadow.layer.shadowRadius = 10
        numberLabel1.text = ""
        numberLabel2.text = ""
        operationSignLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.contentView.backgroundColor = UIColor(red: 0.945, green: 0.949, blue: 0.965, alpha: 1)
            viewWithShadow.backgroundColor = .systemGray5
        } else {
            self.contentView.backgroundColor = UIColor(red: 0.945, green: 0.949, blue: 0.965, alpha: 1)
            viewWithShadow.backgroundColor = .white
        }
    }
    
    override func prepareForReuse() {
        numberLabel1.text = ""
        numberLabel2.text = ""
        operationSignLabel.text = ""
    }
    
    public func setOperation(operation: Operation) {
        
        switch operation {
        // Convert operation
        case .convert(let complexNumber):
            switch complexNumber.numberType {
            case .exp:
                self.numberLabel1.attributedText = attributedStringResult_(moduleZ: complexNumber.part1, arcFi: complexNumber.part2, roundTo: 3, fontSize: 24).0
            case .complex:
                self.numberLabel1.text = complexNumberToString(Re: complexNumber.part1, Im: complexNumber.part2, roundTo: 3)
            }
            self.operationTypeLabel.text = "Конвертувати"
        // Culculate operation
        case .culculate(let calculate):
            // First number
            switch calculate.number1.numberType {
            case .exp:
                let fullString = expNumberToString(moduleZ: calculate.number1.part1, arcFi: calculate.number1.part2, roundTo: 3)
                self.numberLabel1.attributedText = attributedStringResult(fullstringResult: fullString, fontSize: 20)

//                self.numberLabel1.attributedText = attributedStringResult_(moduleZ: calculate.number1.part1, arcFi: calculate.number1.part2, roundTo: 3, fontSize: 20).0
            case .complex:
                self.numberLabel1.text = complexNumberToString(Re: calculate.number1.part1, Im: calculate.number1.part2, roundTo: 3)
            }
            // Second number
            switch calculate.number2.numberType {
            case .exp:
                let fullString = expNumberToString(moduleZ: calculate.number2.part1, arcFi: calculate.number2.part2, roundTo: 3).addParentheses()
                self.numberLabel2.attributedText = attributedStringResult(fullstringResult: fullString, fontSize: 20)
//                self.numberLabel2.attributedText = attributedStringResult_(moduleZ: calculate.number2.part1, arcFi: calculate.number2.part2, roundTo: 3, fontSize: 20).0
            case .complex:
                self.numberLabel2.text = "(" + complexNumberToString(Re: calculate.number2.part1, Im: calculate.number2.part2, roundTo: 3) + ")"
            }
            // Operation Sign
            switch calculate.operation {
            case .plus:
                self.operationSignLabel.text = "➕"
            case .minus:
                self.operationSignLabel.text = "➖"
            case .multiplication:
                self.operationSignLabel.text = "✖️"
            case .division:
                self.operationSignLabel.text = "➗"
            }
            self.operationTypeLabel.text = "Розрахувати"
        }
        
    }
    
}
