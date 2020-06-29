//
//  ShowResultButtonAnimationExtension.swift
//  Calc
//
//  Created by Головаш Анастасия on 28.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension CalculateViewController {
    
    // MARK: - showResultButton Animation
    
    func showResultButtonAnimationSetup() {
        // Hides the showResultButton moving it down
        UIView.animate(withDuration: 0) {
            self.showResultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
        }
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        if notification.name.rawValue == "UIKeyboardWillShowNotification"{
            anwerView.hide()
            UIView.animate(withDuration: 1) {
                self.anwerView.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
            UIView.animate(withDuration: 2) {
                self.showResultButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        } else {
            UIView.animate(withDuration: 2) {
                self.showResultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
            UIView.animate(withDuration: 1) {
                self.anwerView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            anwerView.show()
        }
    }
    
    
    // MARK: - changeFormButtons Animation
    /**
     Change view with exponential form representation to complex and conversely.
     - Parameters:
        - button: Button which will be pressed to change view.
        - expViev: View with exponential form representation.
        - complexView: View with complex form representation.
     */
    func changeForm(button: UIButton, expViev: UIView, complexView: UIView) {
        if button.title(for: .normal) == "Комплексна форма" {
            button.setTitle("Експоненційна форма", for: .normal)
            expViev.isHidden = true
            complexView.isHidden = false
        } else {
            button.setTitle("Комплексна форма", for: .normal)
            complexView.isHidden = true
            expViev.isHidden = false
        }
    }
}
