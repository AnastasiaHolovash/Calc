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
    
    var operationDelegate: OperationDelegate?
    var numberDelegate: NumberDelegate?
    
    public var transferNumber: ComplexNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let historyVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController else { return }
        historyVCc = historyVC
        historyVCc?.tabBarIndexDelegate = self
    }
    
    
    @IBAction func didPressInformationButton(_ sender: UIButton) {
        guard let informationVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InformationViewController") as? InformationViewController else { return }
        
        let navigationC = UINavigationController()
        navigationC.viewControllers = [informationVC]
        navigationC.navigationBar.prefersLargeTitles = true
        navigationC.navigationItem.largeTitleDisplayMode = .always
        
        present(navigationC, animated: true, completion: nil)
    }
    
    @IBAction func didPressHistoryButton(_ sender: UIButton) {
        guard let historyVCc = historyVCc else { return }
        
        let navigationC = UINavigationController()
        navigationC.viewControllers = [historyVCc]
        navigationC.navigationBar.prefersLargeTitles = true
        navigationC.navigationItem.largeTitleDisplayMode = .always
        
        present(navigationC, animated: true, completion: nil)
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
