//
//  ExpView.swift
//  Calc
//
//  Created by Головаш Анастасия on 03.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class ExpView: UIView {
    
    var delegate: ChangeSignBottomsDelegate?

    @IBOutlet weak var beforeExpTextFieldView: CustomBorderedTextField!
    @IBOutlet weak var afterExpTextFieldView: CustomBorderedTextField!
//    @IBOutlet weak var beforeExpSignButton: UIButton!
//    @IBOutlet weak var afterExpSignButton: UIButton!
    @IBOutlet weak var beforeExpSignButton: ChangeSignButton!
    @IBOutlet weak var afterExpSignButton: ChangeSignButton!
    
    var beforeExpTextField: UITextField!
    var afterExpTextField: UITextField!
    
    var beforeExpIsPlus: Bool = true
    var afterExpIsPlus: Bool = true
    
    var view = UIView()

    
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
        let nib = UINib(nibName: "ExpView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    private func setup() {
        let xibView = loudViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        self.beforeExpTextField = beforeExpTextFieldView.textField
        self.afterExpTextField = afterExpTextFieldView.textField
    }
    
    @IBAction func didPressChangeSignButton(_ sender: ChangeSignButton) {
//        if sender === beforeExpSignButton {
//            updateButton(button: sender, isPlus: &beforeExpIsPlus)
//        } else {
//            updateButton(button: sender, isPlus: &afterExpIsPlus)
        if sender === beforeExpSignButton {
            sender.changeSign(isPlus: &beforeExpIsPlus)
        } else {
            sender.changeSign(isPlus: &afterExpIsPlus)
        }
        delegate?.recalculate()
    }

    func beforeExpSignButtonSetSign(setPlus: Bool) {
        if setPlus {
            beforeExpIsPlus = false
        } else {
            beforeExpIsPlus = true
        }
//        updateButton(button: beforeExpSignButton, isPlus: &beforeExpIsPlus)
        beforeExpSignButton.changeSign(isPlus: &beforeExpIsPlus)
    }
    
    func afterExpSignButtonSetSign(setPlus: Bool) {
        if setPlus {
            afterExpIsPlus = false
        } else {
            afterExpIsPlus = true
        }
//        updateButton(button: afterExpSignButton, isPlus: &afterExpIsPlus)
        afterExpSignButton.changeSign(isPlus: &afterExpIsPlus)
    }
    
    
    public func clearView() {
        beforeExpTextField.text = ""
        afterExpTextField.text = ""
        beforeExpSignButtonSetSign(setPlus: true)
        afterExpSignButtonSetSign(setPlus: true)
    }
    
    public func setNumber(beforeExpNumber: Double, afterExpNumber: Double) {
        if beforeExpNumber < 0 {
            self.beforeExpSignButtonSetSign(setPlus: false)
        }
        if afterExpNumber < 0 {
            self.afterExpSignButtonSetSign(setPlus: false)
        }
        self.beforeExpTextField.text = String(abs(beforeExpNumber))
        self.afterExpTextField.text = String(abs(afterExpNumber))
    }

    public func hidekeybourd() {
        beforeExpTextField.resignFirstResponder()
        afterExpTextField.resignFirstResponder()
    }

}
