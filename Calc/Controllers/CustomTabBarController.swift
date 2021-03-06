//
//  CustomTapBarController.swift
//  Calc
//
//  Created by Головаш Анастасия on 17.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

protocol OperationDelegate {
    func setOperationFromHistory(calculate: Calculate?)
}
protocol NumberDelegate {
    func setNumberFromHistory(number: ComplexNumber?)
}

class CustomTabBarController: UITabBarController {
    
    var historyVCc: HistoryViewController?
    var historyNavController: UINavigationController?
    var informationNavController: UINavigationController?
    
    var operationDelegate: OperationDelegate?
    var numberDelegate: NumberDelegate?
    
    public var transferNumber: ComplexNumber?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let informationNC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InformationNavController") as? UINavigationController else { return }
        informationNavController = informationNC
        
        guard let historyNC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryNavController") as? UINavigationController else { return }
        historyNavController = historyNC
        historyVCc = historyNC.viewControllers.first as? HistoryViewController
        historyVCc?.tabBarIndexDelegate = self
    }
    
    
    @IBAction func didPressInformationButton(_ sender: UIButton) {
        present(informationNavController ?? UINavigationController(), animated: true, completion: nil)
    }
    
    @IBAction func didPressHistoryButton(_ sender: UIButton) {
        present(historyNavController ?? UINavigationController(), animated: true, completion: nil)
    }
    
}


extension CustomTabBarController: TabBarIndexDelegate {
    
    func tabBarControllerSelectedIndex(selectedIndex: Int, calculate: Calculate?, number: ComplexNumber?) {
        self.selectedIndex = selectedIndex
                
        switch selectedIndex {
        case 0:
            self.numberDelegate?.setNumberFromHistory(number: number)
        case 1:
            self.operationDelegate?.setOperationFromHistory(calculate: calculate)
        default:
            print("Error")
        }
        self.tabBarController?.selectedIndex = selectedIndex
    }
}
