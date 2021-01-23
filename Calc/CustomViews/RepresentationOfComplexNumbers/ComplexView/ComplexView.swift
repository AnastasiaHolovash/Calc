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
    
    // MARK:- IBOutlets
    @IBOutlet weak var reSignButton: ChangeSignButton!
    @IBOutlet weak var imSignButton: ChangeSignButton!
    
    @IBOutlet weak var reTextFieldView: CustomBorderedTextField!
    @IBOutlet weak var imTextFieldView: CustomBorderedTextField!
    
    // MARK:- Number values
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
        addSubview(xibView)
        reTextField = reTextFieldView.textField
        imTextField = imTextFieldView.textField
    }

    
    @IBAction func didPressSignButton(_ sender: ChangeSignButton) {
        
        if sender === reSignButton {
            sender.changeSign(isPlus: &reIsPlus)
        } else {
            sender.changeSign(isPlus: &imIsPlus)
        }
        delegate?.recalculate()
    }
    
    
    /**
     Sets default values.
     */
    public func clearView() {
        reTextField.text = ""
        imTextField.text = ""
        reSignButtonSetSign(setPlus: true)
        imSignButtonSetSign(setPlus: true)
    }
    
    
    /**
     Sets values from parameters.
     
    - Parameters:
        - reNumber: The real part of the complex number whith sign.
        - imNumber: The imaginary part of the complex number.
     */
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
    
    
    /**
     Sets sign for real part of the complex number.
     */
    func reSignButtonSetSign(setPlus: Bool) {
        if setPlus {
            reIsPlus = false
        } else {
            reIsPlus = true
        }
        reSignButton.changeSign(isPlus: &reIsPlus)
    }
    
    
    /**
    Sets sign for imaginary part of the complex number.
    */
    func imSignButtonSetSign(setPlus: Bool) {
        if setPlus {
            imIsPlus = false
        } else {
            imIsPlus = true
        }
        imSignButton.changeSign(isPlus: &imIsPlus)
    }
    
    
    /**
     Hides all eybourds.
     */
    public func hidekeybourd() {
        reTextField.resignFirstResponder()
        imTextField.resignFirstResponder()
    }

    
}
