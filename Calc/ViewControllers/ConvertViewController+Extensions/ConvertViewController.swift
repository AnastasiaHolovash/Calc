//
//  ViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 27.11.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController {

    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var answerView: AnswerView!
    @IBOutlet weak var changeFormButton: ChangeFormButton!
    
    @IBOutlet weak var expView: ExpView!
    @IBOutlet weak var complexView: ComplexView!
    
    var transferNumber: ComplexNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeFormButtonSetup()
        addObserver()
        setupKeyboardToolbar()
        delegatesSetup()
        viewsSetup()
        
        if !UserData.shared.wasLaunchedBefore {
            guard let informationNC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InformationNavController") as? UINavigationController else { return }
            present(informationNC, animated: true, completion: nil)
            UserData.shared.wasLaunchedBefore = true
        }
        
        recalculate()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = NSLocalizedString("Conversion", comment: "Tab bar controller title")
    }
    
    
    func delegatesSetup() {
        expView.delegate = self
        complexView.delegate = self
        guard let tabBarC = self.tabBarController as? CustomTabBarController else { return }
        tabBarC.numberDelegate = self
    }
    
    
    func viewsSetup() {
        convertButton.layer.cornerRadius = CGFloat(Double(convertButton.frame.height) / 2.5)
        transferButton.layer.cornerRadius = CGFloat(Double(transferButton.frame.height) / 2.5)
        self.answerView.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
    }
    
    
    func changeFormButtonSetup() {
        changeFormButton.expView = expView
        changeFormButton.complexView = complexView
    }
    
    
    func addObserver() {
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    deinit {
        // Stop listening for keyboard show/hide events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @IBAction func didPressTransferButton(_ sender: UIButton) {
        guard let tabBarC = self.tabBarController as? CustomTabBarController else { return }
        tabBarC.transferNumber = transferNumber
        tabBarC.selectedIndex = 1
    }
    
    
    @IBAction func didPressConvert(_ sender: UIButton) {
        switch changeFormButton.curentForm {
        case .exp:
            let expNumber = makeExpNumber()
            showComplexResult(modulZ: expNumber.modulZ, arc: expNumber.arc)
            
            // For history updating
            let operation = Operation.convert(ComplexNumber(numberType: NumberType.exp, part1: expNumber.modulZ , part2: expNumber.arc))
            History.shared.addOperationToHistory(operation: operation)
            
            expView.hidekeybourd()
            complexView.hidekeybourd()
                
        case .complex:
            let complexNumber = makeComplexNumber()
            showExpResult(re: complexNumber.re, im: complexNumber.im)
            
            // For history updating
            let operation = Operation.convert(ComplexNumber(numberType: NumberType.complex, part1: complexNumber.re , part2: complexNumber.im))
            History.shared.addOperationToHistory(operation: operation)
            
            expView.hidekeybourd()
            complexView.hidekeybourd()
        }
    }
    
    
    @IBAction func didPressChangeForm(_ sender: ChangeFormButton) {
        sender.changeForm()
        switch changeFormButton.curentForm {
        case .exp:
            let expNumber = makeExpNumber()
            showComplexResult(modulZ: expNumber.modulZ, arc: expNumber.arc)
        case .complex:
            let complexNumber = makeComplexNumber()
            showExpResult(re: complexNumber.re, im: complexNumber.im)
        }
    }
    
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        expView.hidekeybourd()
        complexView.hidekeybourd()
    }
    
    
}


extension ConvertViewController: ChangeSignBottomsDelegate {
    
    func recalculate() {
        switch changeFormButton.curentForm {
        case .exp:
            let expNumber = makeExpNumber()
            showComplexResult(modulZ: expNumber.modulZ, arc: expNumber.arc)
        case .complex:
            let complexNumber = makeComplexNumber()
            showExpResult(re: complexNumber.re, im: complexNumber.im)
        }
    }
    
}
