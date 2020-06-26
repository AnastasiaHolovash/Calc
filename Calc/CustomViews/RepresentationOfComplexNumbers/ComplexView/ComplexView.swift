//
//  ComplexView.swift
//  Calc
//
//  Created by Головаш Анастасия on 09.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class ComplexView: UIView {
    
    @IBOutlet weak var reSignButton: UIButton!
    @IBOutlet weak var imSignButton: UIButton!
    
    @IBOutlet weak var reTextField: UITextField!
    @IBOutlet weak var imTextField: UITextField!
    
    var reIsPlus: Bool = true
    var imIsPlus: Bool = true
    
    let plusImage = UIImage(systemName: "plus.circle.fill")
    let minusImage = UIImage(systemName: "minus.circle.fill")
    
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
        let nib = UINib(nibName: "ComplexView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    private func setup() {
        let xibView = loudViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }

    @IBAction func didPressSignButton(_ sender: UIButton) {
        if sender === reSignButton {
            updateButton(button: sender, isPlus: &reIsPlus)
        } else {
            updateButton(button: sender, isPlus: &imIsPlus)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reTextField.setRoundedBourder()
        imTextField.setRoundedBourder()
    }
    
    public func reSignButtonSetSign(setPlus: Bool) {
        if setPlus {
            reIsPlus = false
        } else {
            reIsPlus = true
        }
        updateButton(button: reSignButton, isPlus: &reIsPlus)
    }
    
    public func imSignButtonSetSign(setPlus: Bool) {
        if setPlus {
            imIsPlus = false
        } else {
            imIsPlus = true
        }
        updateButton(button: imSignButton, isPlus: &imIsPlus)
    }
    
    public func clearView() {
        reTextField.text = ""
        imTextField.text = ""
        reSignButtonSetSign(setPlus: true)
        imSignButtonSetSign(setPlus: true)
    }
    
    public func setNumber(reNumber: Double, imNumber: Double) {
        if reNumber < 0 {
            self.reSignButtonSetSign(setPlus: false)
        }
        if imNumber < 0 {
            self.imSignButtonSetSign(setPlus: false)
        }
        self.reTextField.text = String(abs(reNumber))
        self.imTextField.text = String(abs(imNumber))
    }
    
    public func hidekeybourd() {
        reTextField.resignFirstResponder()
        imTextField.resignFirstResponder()
    }

    
}
