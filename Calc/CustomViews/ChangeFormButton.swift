//
//  ChangeFormButton.swift
//  Calc
//
//  Created by Головаш Анастасия on 30.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class ChangeFormButton: UIButton {
        
    var expView: UIView?
    var complexView: UIView?
    var curentForm: NumberType = .exp
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    func changeForm() {
        if let expView = expView, let complexView = complexView {
            switch curentForm {
            case .exp:
                expView.isHidden = true
                complexView.isHidden = false
                curentForm = .complex
            case .complex:
                complexView.isHidden = true
                expView.isHidden = false
                curentForm = .exp
            }
//            if self.title(for: .normal) == "Комплексна форма" {
//                self.setTitle("Експоненційна форма", for: .normal)
//                expView.isHidden = true
//                complexView.isHidden = false
//            } else {
//                self.setTitle("Комплексна форма", for: .normal)
//                complexView.isHidden = true
//                expView.isHidden = false
//            }
        }
    }

    
    private func setup() {
        self.backgroundColor = .systemIndigo
        self.setTitle("Змінити форму", for: .normal)
        self.tintColor = .white
//        self.titleLabel?.font.withSize(CGFloat(integerLiteral: 17))
//        self.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.layer.cornerRadius = CGFloat((Double(self.frame.height) ) / 2.5)

    }
    
}
