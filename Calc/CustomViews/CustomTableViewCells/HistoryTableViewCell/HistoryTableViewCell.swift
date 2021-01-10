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
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
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
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(lessThanOrEqualTo: viewWithShadow.widthAnchor, constant: -54)
        ])
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
                var fullString = expNumberToStringWithFormating(moduleZ: complexNumber.part1, arcFi: complexNumber.part2 ?? 0.0, roundTo: 3)
                self.numberLabel1.attributedText = attributedStringResultWithFormating(fullstringResult: &fullString, fontSize: 20)
            case .complex:
                self.numberLabel1.attributedText = complexNumberToStringWithFormating(Re: complexNumber.part1, Im: complexNumber.part2 ?? 0.0, roundTo: 3)
            case .n:
                print("Error")
            }
            self.numberLabel1.textAlignment = .left
            self.operationTypeLabel.text = NSLocalizedString("Convert", comment: "")
            
        // Culculate operation
        case .calculate(let calculate):
            
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
            case .pow:
                print("Pow")
            case .root:
                print("Root")
            }
            
            // First number
            switch calculate.number1.numberType {
            case .exp:
                var fullString = (.pow == calculate.operation) || (.root == calculate.operation) ? "(" : ""
                fullString += expNumberToStringWithFormating(moduleZ: calculate.number1.part1, arcFi: calculate.number1.part2 ?? 0.0, roundTo: 3)
                fullString += (.pow == calculate.operation) || (.root == calculate.operation) ? ")\(Int(calculate.number2.part1))" : ""
                self.numberLabel1.attributedText = attributedStringResultWithFormating(fullstringResult: &fullString, fontSize: 20)
            case .complex:

                let firstResult = NSMutableAttributedString()
                firstResult.append(NSAttributedString(string: "("))
                firstResult.append(complexNumberToStringWithFormating(Re: calculate.number1.part1, Im: calculate.number1.part2 ?? 0.0, roundTo: 3))
                firstResult.append(NSAttributedString(string: ")"))
                self.numberLabel1.attributedText = firstResult
            case .n:
                print("Error")
            }
            
            // Second number
            switch calculate.number2.numberType {
            case .exp:
                var fullString = expNumberToStringWithFormating(moduleZ: calculate.number2.part1, arcFi: calculate.number2.part2 ?? 0.0, roundTo: 3).addParentheses()
                self.numberLabel2.attributedText = attributedStringResultWithFormating(fullstringResult: &fullString, fontSize: 20)
            case .complex:
                let secondResult = NSMutableAttributedString()
                secondResult.append(NSAttributedString(string: "("))
                secondResult.append(complexNumberToStringWithFormating(Re: calculate.number2.part1, Im: calculate.number2.part2 ?? 0.0, roundTo: 3))
                secondResult.append(NSAttributedString(string: ")"))
                self.numberLabel2.attributedText = secondResult
            case .n:
                print("n = \(calculate.number2.part1)")
            }
            
            self.operationTypeLabel.text = NSLocalizedString("Calculate", comment: "")
        }
    }
}
