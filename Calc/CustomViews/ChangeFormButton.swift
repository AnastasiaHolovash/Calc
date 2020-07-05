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
        }
    }

    
    private func setup() {
        super.layoutSubviews()
        self.backgroundColor = .systemIndigo
        self.tintColor = .white
        self.layer.cornerRadius = CGFloat((Double(self.frame.height) ) / 2.5)

    }
    
    override func layoutSubviews() {

        if let label = self.titleLabel {
            self.setTitle("Змінити форму", for: .normal)
            label.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }
    
}
