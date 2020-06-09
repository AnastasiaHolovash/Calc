//
//  ExpView.swift
//  Calc
//
//  Created by Головаш Анастасия on 03.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class ExpView: UIView {

    @IBOutlet weak var beforeExpTextField: UITextField!
    @IBOutlet weak var afterExpTextField: UITextField!
    
    @IBOutlet weak var beforeExpSignButton: UIButton!
    @IBOutlet weak var afterExpSignButton: UIButton!
    
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
    }
    
    @IBAction func didPressChangeSignButton(_ sender: UIButton) {
        if sender === beforeExpSignButton {
            updateButton(button: sender, isPlus: &beforeExpIsPlus)
        } else {
            updateButton(button: sender, isPlus: &afterExpIsPlus)
        }
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        beforeExpTextField.setRoundedBourder()
        afterExpTextField.setRoundedBourder()

    }


}
