//
//  CalculateViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 01.12.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    @IBOutlet weak var changeFormButton1: UIButton!
    @IBOutlet weak var changeFormButton2: UIButton!

    @IBOutlet weak var expView1: UIView!
    @IBOutlet weak var complexView1: UIView!
    @IBOutlet weak var expView2: UIView!
    @IBOutlet weak var complexView2: UIView!
//  Sidn Buttons
    @IBOutlet weak var modulZSignButton1: UIButton!
    @IBOutlet weak var modulZSignButton2: UIButton!
    @IBOutlet weak var angleSignButton1: UIButton!
    @IBOutlet weak var angleSignButton2: UIButton!
    @IBOutlet weak var signReButton1: UIButton!
    @IBOutlet weak var signReButton2: UIButton!
    @IBOutlet weak var signImButton1: UIButton!
    @IBOutlet weak var signImButton2: UIButton!
//  Text Fields
    @IBOutlet weak var beforeExpTextField1: UITextField!
    @IBOutlet weak var beforeExpTextField2: UITextField!
    @IBOutlet weak var angleExpTextField1: UITextField!
    @IBOutlet weak var angleExpTextField2: UITextField!
    @IBOutlet weak var complexReTextField1: UITextField!
    @IBOutlet weak var complexReTextField2: UITextField!
    @IBOutlet weak var complexImTextField1: UITextField!
    @IBOutlet weak var complexImTextField2: UITextField!
//  Operation Sidn Buttons
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeFormButton1.layer.cornerRadius = CGFloat((Double(changeFormButton1.frame.height) ) / 2.0)
        changeFormButton2.layer.cornerRadius = CGFloat((Double(changeFormButton2.frame.height) ) / 2.0)

    }
    
    
    func changeForm(button: UIButton, expViev: UIView, complexView: UIView) {
        if button.title(for: .normal) == "Complex form" {
            button.setTitle("Exp form", for: .normal)
            expViev.isHidden = true
            complexView.isHidden = false
        } else {
            button.setTitle("Complex form", for: .normal)
            complexView.isHidden = true
            expViev.isHidden = false
        }
    }
    
    
    func selectedOperation(button: UIButton, imageName: String) {
        plusButton.setImage(UIImage.init(systemName: "plus.square"), for: .normal)
        minusButton.setImage(UIImage.init(systemName: "minus.square"), for: .normal)
        multiplyButton.setImage(UIImage.init(systemName: "multiply.square"), for: .normal)
        divideButton.setImage(UIImage.init(systemName: "divide.square"), for: .normal)
        button.setImage(UIImage.init(systemName: imageName), for: .normal)
    }
    
//    func changeSign(_ buttton: UIButton) {
//        if buttton.title(for: .normal) == "+" {
//            buttton.setTitle("-", for: .normal)
//        } else {
//            buttton.setTitle("+", for: .normal)
//        }
//    }

    
    @IBAction func changeFormAction1(_ sender: UIButton) {
        changeForm(button: changeFormButton1, expViev: expView1, complexView: complexView1)
    }
    @IBAction func changeFormAction2(_ sender: UIButton) {
        changeForm(button: changeFormButton2, expViev: expView2, complexView: complexView2)
    }

    
    @IBAction func didChangeModulZSign1(_ sender: UIButton) {
        changeSign(modulZSignButton1)
    }
    @IBAction func didChangeModulZSign2(_ sender: UIButton) {
        changeSign(modulZSignButton2)
    }
    @IBAction func didChangeAngleSign1(_ sender: UIButton) {
        changeSign(angleSignButton1)
    }
    @IBAction func didChangeAngleSign2(_ sender: UIButton) {
        changeSign(angleSignButton2)
    }
    @IBAction func didChangeReSign1(_ sender: UIButton) {
        changeSign(signReButton1)
    }
    @IBAction func didChangeReSign2(_ sender: UIButton) {
        changeSign(signReButton2)
    }
    @IBAction func didChangeImSign1(_ sender: UIButton) {
        changeSign(signImButton1)
    }
    @IBAction func didChangeImSign2(_ sender: UIButton) {
        changeSign(signImButton2)
    }
    

    @IBAction func selectedPlusOperation(_ sender: UIButton) {
        selectedOperation(button: plusButton, imageName: "plus.square.fill")
    }
    @IBAction func selectedMinusOperation(_ sender: UIButton) {
        selectedOperation(button: minusButton, imageName: "minus.square.fill")
    }
    @IBAction func selectedMultiplyOperation(_ sender: UIButton) {
        selectedOperation(button: multiplyButton, imageName: "multiply.square.fill")
    }
    @IBAction func selectedDivideOperation(_ sender: UIButton) {
        selectedOperation(button: divideButton, imageName: "divide.square.fill")

    }
    @IBAction func didPressEqual(_ sender: UIButton) {
        print(plusButton.isSelected)
    }
    
    
    
    
}
