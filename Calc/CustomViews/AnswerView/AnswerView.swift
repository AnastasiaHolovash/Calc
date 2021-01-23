//
//  AnswerView.swift
//  Calc
//
//  Created by Головаш Анастасия on 29.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class AnswerView: UIView {
    
    @IBOutlet weak var viewWithShadow: UIView!
    @IBOutlet weak var expAnswerLabel: UILabel!
    @IBOutlet weak var complexAnswerLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func loudViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AnswerView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    private func setup() {
        let xibView = loudViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        numberLabel.isHidden = true
        addSubview(xibView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = mainBackgroundColor
        numberLabel.layer.borderWidth = 1.5
        numberLabel.layer.borderColor = UIColor.label.cgColor
        numberLabel.layer.cornerRadius = numberLabel.frame.height / 2
        viewWithShadow.addShadow()
    }
    
}
