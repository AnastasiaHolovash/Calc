//
//  NView.swift
//  Calc
//
//  Created by Anastasia Holovash on 09.01.2021.
//  Copyright © 2021 Anastasia. All rights reserved.
//

import UIKit

class NView: UIView {
    
    @IBOutlet weak var nTextFieldView: CustomBorderedTextField!
    
    var textField: UITextField!
    
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
        let nib = UINib(nibName: "NView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    
    private func setup() {
        let xibView = loudViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
        textField = nTextFieldView.textField
    }
    
    override func layoutSubviews() {
        textField.keyboardType = .numberPad
        textField.placeholder = "1"
    }
    
    /**
     Sets value from parameters.
     */
    public func setNumber(number: Double) {
        self.textField.text = String(Int(number))
    }
    
    /**
     Sets default values.
     */
    public func clearView() {
        textField.text = "1"
    }
    
    /**
     Hides kybourd.
     */
    public func hidekeybourd() {
        textField.resignFirstResponder()
    }
    
}
