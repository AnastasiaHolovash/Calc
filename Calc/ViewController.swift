//
//  ViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 27.11.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var beforeExpTextField: UITextField!
    @IBOutlet weak var angleExpTextField: UITextField!
    @IBOutlet weak var complexReTextField: UITextField!
    @IBOutlet weak var complexImTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var signButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var try1 = "123"
    var try2 = "555"

    @IBAction func didPressConvert(_ sender: UIButton) {
        resultLabel.text = try1 + try2
        print(beforeExpTextField.text ?? "nothing")
        print(angleExpTextField.text ?? "nothing")
    }
    
    @IBAction func didChangeSign(_ sender: UIButton) {
        if signButton.title(for: .normal) == "+"{
            signButton.setTitle("-", for: .normal)
        }else{
            signButton.setTitle("+", for: .normal)
        }
        
    }
    

}
