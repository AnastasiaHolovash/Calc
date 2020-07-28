//
//  AnimationsExtension.swift
//  Calc
//
//  Created by Головаш Анастасия on 29.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension ConvertViewController {
    
    @objc func keyboardWillChange(notification: Notification) {
        //  MARK:- movement animation
        if notification.name.rawValue == "UIKeyboardWillShowNotification"{
            UIView.animate(withDuration: 1) {
                self.answerView.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.answerView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
    }
    
    
    func setupKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
                    
        expView.beforeExpTextField.inputAccessoryView = toolbar
        expView.afterExpTextField.inputAccessoryView = toolbar
        complexView.reTextField.inputAccessoryView = toolbar
        complexView.imTextField.inputAccessoryView = toolbar
    }
       
    
    @objc func doneAction() {
        view.endEditing(true)
    }
    
}
