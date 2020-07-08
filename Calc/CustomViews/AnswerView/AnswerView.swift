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
        self.addSubview(xibView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = mainBackgroundColor
        viewWithShadow.addShadow()
        expAnswerLabel.text = ""
        complexAnswerLabel.text = ""
    }
    
    public func show() {
        UIView.animate(withDuration: 2) {
            self.viewWithShadow.alpha = 1
        }
    }
    
    public func hide() {
        UIView.animate(withDuration: 2) {
            self.viewWithShadow.alpha = 0
        }
    }
}
