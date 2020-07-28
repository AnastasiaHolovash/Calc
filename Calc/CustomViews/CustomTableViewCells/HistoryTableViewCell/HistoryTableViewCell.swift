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
    @IBOutlet weak var operationSignImage: UIImageView!
    @IBOutlet weak var numberLabel2: UILabel!
    @IBOutlet weak var operationTypeLabel: UILabel!
    @IBOutlet weak var numberLabel1Width: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = mainBackgroundColor
        viewWithShadow.addShadow()
        numberLabel1.text = ""
        numberLabel2.text = ""
        operationSignImage.image = nil
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
        operationSignImage.image = nil
    }
    
    // MAKR: - divide for several funcs
    public func setOperation(operation: Operation) {
        
        switch operation {
            
        // Convert operation
        case .convert(let complexNumber):
            switch complexNumber.numberType {
            case .exp:
                var fullString = expNumberToStringWithFormating(moduleZ: complexNumber.part1, arcFi: complexNumber.part2, roundTo: 3)
                self.numberLabel1.attributedText = attributedStringResultWithFormating(fullstringResult: &fullString, fontSize: 20)
            case .complex:
                self.numberLabel1.attributedText = complexNumberToStringWithFormating(Re: complexNumber.part1, Im: complexNumber.part2, roundTo: 3)
            }
            self.numberLabel1.textAlignment = .left
//            self.numberLabel1Width.constant = 267
            self.operationTypeLabel.text = "Конвертувати"
            
        // Culculate operation
        case .calculate(let calculate):
            // First number
            
            switch calculate.number1.numberType {
            case .exp:
                var fullString = expNumberToStringWithFormating(moduleZ: calculate.number1.part1, arcFi: calculate.number1.part2, roundTo: 3)
                self.numberLabel1.attributedText = attributedStringResultWithFormating(fullstringResult: &fullString, fontSize: 20)
            case .complex:
//                self.numberLabel1.text = "(" + complexNumberToString(Re: calculate.number1.part1, Im: calculate.number1.part2, roundTo: 3) + ")"
                let firstResult = NSMutableAttributedString()
                firstResult.append(NSAttributedString(string: "("))
                firstResult.append(complexNumberToStringWithFormating(Re: calculate.number1.part1, Im: calculate.number1.part2, roundTo: 3))
                firstResult.append(NSAttributedString(string: ")"))
                self.numberLabel1.attributedText = firstResult
            }
            // Second number
            switch calculate.number2.numberType {
            case .exp:
                var fullString = expNumberToStringWithFormating(moduleZ: calculate.number2.part1, arcFi: calculate.number2.part2, roundTo: 3).addParentheses()
                self.numberLabel2.attributedText = attributedStringResultWithFormating(fullstringResult: &fullString, fontSize: 20)
            case .complex:
//                self.numberLabel2.text = "(" + complexNumberToString(Re: calculate.number2.part1, Im: calculate.number2.part2, roundTo: 3) + ")"
                let secondResult = NSMutableAttributedString()
                secondResult.append(NSAttributedString(string: "("))
                secondResult.append(complexNumberToStringWithFormating(Re: calculate.number2.part1, Im: calculate.number2.part2, roundTo: 3))
                secondResult.append(NSAttributedString(string: ")"))
                self.numberLabel2.attributedText = secondResult
            }
            
            // Operation Sign
            switch calculate.operation {
            case .plus:
                self.operationSignImage.image = UIImage(named: "plus")
            case .minus:
                self.operationSignImage.image = UIImage(named: "minus")
            case .multiplication:
                self.operationSignImage.image = UIImage(named: "multiply")
            case .division:
                self.operationSignImage.image = UIImage(named: "divide")
            }
            self.numberLabel1.textAlignment = .center
//            self.numberLabel1Width.constant = 122
            self.operationTypeLabel.text = "Розрахувати"
        }
        
    }
    
}
