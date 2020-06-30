//
//  ChangeFormButton.swift
//  Calc
//
//  Created by Головаш Анастасия on 30.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

//protocol ChangeFormButtonDelegate {
//    func changedForm()
//}

class ChangeFormButton: UIButton {
    
//    var delegate: ChangeFormButtonDelegate?
    
    var expView: UIView?
    var complexView: UIView?
    
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
            if self.title(for: .normal) == "Комплексна форма" {
                self.setTitle("Експоненційна форма", for: .normal)
                expView.isHidden = true
                complexView.isHidden = false
            } else {
                self.setTitle("Комплексна форма", for: .normal)
                complexView.isHidden = true
                expView.isHidden = false
            }
        }
//        self.delegate?.changedForm()
    }

    private func setup() {
        self.backgroundColor = .systemIndigo
        self.setTitle("Змінити форму", for: .normal)
        self.layer.cornerRadius = CGFloat((Double(self.frame.height) ) / 2.5)

    }
    
//    override func layoutSubviews() {
//        self.backgroundColor = .systemIndigo
//        self.setTitle("Змінити форму", for: .normal)
//        self.layer.cornerRadius = CGFloat((Double(self.frame.height) ) / 2.5)
//    }
    
}
