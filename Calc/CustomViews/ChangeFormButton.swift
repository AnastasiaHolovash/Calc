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
        super.layoutSubviews()
        self.backgroundColor = .systemIndigo
        self.tintColor = .white
        self.layer.cornerRadius = CGFloat((Double(self.frame.height) ) / 2.5)
//        self.setTitle("Змінити форму", for: .normal)
//        self.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 5)
    }
    
    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.backgroundColor = .systemIndigo
        if let label = self.titleLabel {
            self.setTitle("Змінити форму", for: .normal)
            label.font = .systemFont(ofSize: 17, weight: .semibold)
        }
        
//        self.tintColor = .white
//        self.layer.cornerRadius = CGFloat((Double(self.frame.height) ) / 2.5)
//        self.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 25)
    }
    
}
