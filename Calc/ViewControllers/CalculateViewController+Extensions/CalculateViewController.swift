//
//  CalculateViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 01.12.2019.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var changeFormButton1: ChangeFormButton!
    @IBOutlet weak var changeFormButton2: ChangeFormButton!
    @IBOutlet weak var changeFormButtonSuperHeight1: NSLayoutConstraint!
    @IBOutlet weak var changeFormButtonSuperHeight2: NSLayoutConstraint!
    
    @IBOutlet weak var generalAnswerView: UIView!
    @IBOutlet weak var answerView: AnswerView!
    @IBOutlet weak var answerScrollView: UIScrollView!
    @IBOutlet weak var answerPageControl: UIPageControl!
    
    @IBOutlet weak var showResultButton: UIButton!
    @IBOutlet weak var showResultButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var operationBar: OperationBar!
    
    @IBOutlet weak var expView1: ExpView!
    @IBOutlet weak var complexView1: ComplexView!
    
    @IBOutlet weak var expView2: ExpView!
    @IBOutlet weak var complexView2: ComplexView!
    @IBOutlet weak var nView: NView!
    
    /// number for save
    var firstNumber: ComplexNumber = ComplexNumber(numberType: NumberType.exp, part1: 0.0, part2: 0.0)
    /// number for save
    var secondNumber: ComplexNumber = ComplexNumber(numberType: NumberType.exp, part1: 0.0, part2: 0.0)
    /// Array of Answer Views for root operation redults
    var answerViews: [AnswerView] = []
        
    var tabBarC: CustomTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
        buttonsSetup()
        showResultAnimationSetup()
        operationBar.changeSelectedOperation()
        delegatesSetup()
        
        recalculate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = NSLocalizedString("Calculator", comment: "")
        
        if let number = tabBarC.transferNumber {
            switch number.numberType {
            case .exp:
                expView1.setNumber(beforeExpNumber: number.part1.simpleRound(decimalPlases: 4), afterExpNumber: number.part2?.simpleRound(decimalPlases: 4) ?? 0.0)
                if expView1.isHidden {
                    changeFormButton1.changeForm()
                }
            case .complex:
                complexView1.setNumber(reNumber: number.part1.simpleRound(decimalPlases: 4), imNumber: number.part2?.simpleRound(decimalPlases: 4) ?? 0.0)
                if complexView1.isHidden {
                    changeFormButton1.changeForm()
                }
            default:
                print("Error")
            }
            tabBarC.transferNumber = nil
        }
    }
    
    private func delegatesSetup() {
        expView1.delegate = self
        expView2.delegate = self
        complexView1.delegate = self
        complexView2.delegate = self
        answerScrollView.delegate = self
        
        guard let tabBar = self.tabBarController as? CustomTabBarController else { return }
        tabBarC = tabBar
        tabBarC.operationDelegate = self
        operationBar.delegate = self
        
        nView.textField.addTarget(self, action : #selector(nTextFieldDidChange), for : .editingChanged)
    }
    
    @objc func nTextFieldDidChange() {
        let enteredNumber = Int(nView.textField.text ?? "1") ?? 1
        if enteredNumber > 100 {
            showResultButton.isUserInteractionEnabled = false
            showResultButton.backgroundColor = .gray
        } else {
            showResultButton.isUserInteractionEnabled = true
            showResultButton.backgroundColor = .systemOrange
        }
    }
    
    private func addObserver() {
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        // Stop listening for keyboard show/hide events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func buttonsSetup() {
        changeFormButton1.expView = expView1
        changeFormButton1.complexView = complexView1
        changeFormButton2.expView = expView2
        changeFormButton2.complexView = complexView2
        
        if UIScreen.main.nativeBounds.height < 1140 {
            NSLayoutConstraint.activate([
                showResultButton.heightAnchor.constraint(equalToConstant: 30),
                showResultButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 47),
                changeFormButton1.heightAnchor.constraint(equalToConstant: 30),
                changeFormButton2.heightAnchor.constraint(equalToConstant: 30),
            ])
            showResultButton.layer.cornerRadius = CGFloat((Double(showResultButton.frame.height) ) / 3.75)
            changeFormButton1.layer.cornerRadius = CGFloat((Double(changeFormButton1.frame.height) ) / 3.75)
            changeFormButton2.layer.cornerRadius = CGFloat((Double(changeFormButton2.frame.height) ) / 3.75)
            changeFormButtonSuperHeight1.constant = -10
            changeFormButtonSuperHeight2.constant = -10
        } else {
            showResultButton.layer.cornerRadius = CGFloat((Double(showResultButton.frame.height) ) / 2.5)
        }
        
        answerPageControl.currentPageIndicatorTintColor = .label
        answerPageControl.pageIndicatorTintColor = .lightGray
    }
    
    @IBAction func didPressChangeForm(_ sender: ChangeFormButton) {
        sender.changeForm()
        recalculate()
    }
    
    
    @IBAction func didPressShowResult(_ sender: UIButton) {
        recalculate()
        expView1.hidekeybourd()
        expView2.hidekeybourd()
        complexView1.hidekeybourd()
        complexView2.hidekeybourd()
        nView.hidekeybourd()
        prepareNumbersForHistoryUpdating()
        let operation = Operation.calculate(Calculate(operation: operationBar.curentOperationName, number1: firstNumber, number2: secondNumber))
        History.shared.addOperationToHistory(operation: operation)
    }
    
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        expView1.hidekeybourd()
        expView2.hidekeybourd()
        complexView1.hidekeybourd()
        complexView2.hidekeybourd()
        nView.hidekeybourd()
    }
    
    
    @IBAction func didChangeAnswerPageControl(_ sender: UIPageControl) {
        answerScrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(sender.currentPage), y: 0), animated: true)
    }
    
}


extension CalculateViewController: OperationDelegate {
    
    func setOperationFromHistory(calculate: Calculate?) {
        if let calculate = calculate {
            setNumbers(number1: calculate.number1, number2: calculate.number2)
            operationBar.curentOperationName = calculate.operation
            operationBar.changeSelectedOperation()
            recalculate()
            if operationBar.curentOperationName == .root {
                self.answerScrollView.transform = CGAffineTransform(translationX: 0, y: 0)
            } else {
                self.answerView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
    }
    
}

extension CalculateViewController: OperationBarDelegate {
    func selectedPowOrRootOperation() {
        expView2.isHidden = true
        complexView2.isHidden = true
        nView.isHidden = false
        changeFormButton2.isUserInteractionEnabled = false
        changeFormButton2.backgroundColor = .gray
        
        let enteredNumber = Int(nView.textField.text ?? "1") ?? 1
        if enteredNumber > 100 {
            nView.textField.text = "1"
        }
        recalculate()
    }
    
    func selectedSwapOperation() {
        prepareNumbersForHistoryUpdating()
        setNumbers(number1: secondNumber, number2: firstNumber)
        recalculate()
    }
    
    func selectedNewSimpleOperation() {
        nView.isHidden = true
        switch changeFormButton2.curentForm {
        case .complex:
            complexView2.isHidden = false
        case .exp:
            expView2.isHidden = false
        default:
            print("Error")
        }
        changeFormButton2.isUserInteractionEnabled = true
        changeFormButton2.backgroundColor = .systemIndigo
        showResultButton.backgroundColor = .systemOrange
        recalculate()
    }
}

extension CalculateViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(Float(scrollView.contentOffset.x / view.frame.width))
        answerPageControl.currentPage = Int(pageIndex)
    }
}

