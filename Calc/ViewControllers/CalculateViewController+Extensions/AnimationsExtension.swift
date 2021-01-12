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
        self.showResultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
        self.answerView.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
        self.answerScrollView.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
        self.answerPageControl.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        if notification.name.rawValue == "UIKeyboardWillShowNotification"{
            UIView.animate(withDuration: 1) {
                self.answerScrollView.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
            UIView.animate(withDuration: 1) {
                self.answerPageControl.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
            UIView.animate(withDuration: 1) {
                self.answerView.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
            UIView.animate(withDuration: 2) {
                self.showResultButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        } else {
            
            UIView.animate(withDuration: 2) {
                self.showResultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
            if operationBar.curentOperationName == .root {
                UIView.animate(withDuration: 1) {
                    self.answerScrollView.transform = CGAffineTransform(translationX: 0, y: 0)
                }
                UIView.animate(withDuration: 1) {
                    self.answerPageControl.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            } else {
                UIView.animate(withDuration: 1) {
                    self.answerView.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            }
        }
    }
    
    

}
