//
//  ComplexView.swift
//  Calc
//
//  Created by Головаш Анастасия on 09.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class ComplexView: UIView {
    
    var delegate: ChangeSignBottomsDelegate?
    
    @IBOutlet weak var reSignButton: UIButton!
    @IBOutlet weak var imSignButton: UIButton!
    
    @IBOutlet weak var reTextFieldView: CustomBorderedTextField!
    @IBOutlet weak var imTextFieldView: CustomBorderedTextField!
    
    var reTextField: UITextField!
    var imTextField: UITextField!
    var reIsPlus: Bool = true
    var imIsPlus: Bool = true

    
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
        reTextField = reTextFieldView.textField
        imTextField = imTextFieldView.textField
    }

    @IBAction func didPressSignButton(_ sender: UIButton) {
        if sender === reSignButton {
            updateButton(button: sender, isPlus: &reIsPlus)
        } else {
            updateButton(button: sender, isPlus: &imIsPlus)
        }
        delegate?.recalculate()
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
