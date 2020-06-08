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
//        reTextField.layer.borderWidth = 1
//        imTextField.layer.borderWidth = 1
//        reTextField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        imTextField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        reTextField.layer.cornerRadius = reTextField.frame.height / 2.5
//        imTextField.layer.cornerRadius = imTextField.frame.height / 2.5
    }
    
}
