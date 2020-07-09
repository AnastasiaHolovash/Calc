//
//  TableViewCell.swift
//  Calc
//
//  Created by Головаш Анастасия on 17.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var viewWithShadow: UIView!
    @IBOutlet weak var numberLabel1: UILabel!
    @IBOutlet weak var numberLabel2: UILabel!
    @IBOutlet weak var operationSignLabel: UILabel!
    @IBOutlet weak var operationTypeLabel: UILabel!
    @IBOutlet weak var numberLabel1Width: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = mainBackgroundColor
        viewWithShadow.addShadow()
        numberLabel1.text = ""
        numberLabel2.text = ""
        operationSignLabel.text = ""
        numberLabel1.adjustsFontSizeToFitWidth = true
        numberLabel2.adjustsFontSizeToFitWidth = true
        numberLabel1.minimumScaleFactor = 0.5
        numberLabel2.minimumScaleFactor = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.contentView.backgroundColor = mainBackgroundColor
            viewWithShadow.backgroundColor = .systemGray5
        } else {
            self.contentView.backgroundColor = mainBackgroundColor
            viewWithShadow.backgroundColor = infoPresentBackgroundColor
        }
    }
    
    override func prepareForReuse() {
        numberLabel1.text = ""
        numberLabel2.text = ""
        operationSignLabel.text = ""
    }
    
    // MAKR: - divide for several funcs
    public func setOperation(operation: Operation) {
        
        switch operation {
        // Convert operation
        case .convert(let complexNumber):
            switch complexNumber.numberType {
            case .exp:
                let fullString = expNumberToString(moduleZ: complexNumber.part1, arcFi: complexNumber.part2, roundTo: 3)
                self.numberLabel1.attributedText = attributedStringResult(fullstringResult: fullString, fontSize: 20)
            case .complex:
                self.numberLabel1.text = complexNumberToString(Re: complexNumber.part1, Im: complexNumber.part2, roundTo: 3)
            }
            self.numberLabel1.textAlignment = .left
            self.numberLabel1Width.constant = 267
            self.operationTypeLabel.text = "Конвертувати"
        // Culculate operation
        case .calculate(let calculate):
            // First number
            switch calculate.number1.numberType {
            case .exp:
                let fullString = expNumberToString(moduleZ: calculate.number1.part1, arcFi: calculate.number1.part2, roundTo: 3)
                self.numberLabel1.attributedText = attributedStringResult(fullstringResult: fullString, fontSize: 20)
            case .complex:
                self.numberLabel1.text = "(" + complexNumberToString(Re: calculate.number1.part1, Im: calculate.number1.part2, roundTo: 3) + ")"
            }
            // Second number
            switch calculate.number2.numberType {
            case .exp:
                let fullString = expNumberToString(moduleZ: calculate.number2.part1, arcFi: calculate.number2.part2, roundTo: 3).addParentheses()
                self.numberLabel2.attributedText = attributedStringResult(fullstringResult: fullString, fontSize: 20)
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
            self.numberLabel1.textAlignment = .center
            self.numberLabel1Width.constant = 122
            self.operationTypeLabel.text = "Розрахувати"
        }
        
    }
    
}
