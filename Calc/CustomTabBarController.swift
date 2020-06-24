//
//  CustomTapBarController.swift
//  Calc
//
//  Created by Головаш Анастасия on 17.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit



class CustomTabBarController: UITabBarController, HistoryViewControllerDelegate {
    
    var historyVCc: HistoryViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let historyVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController else { return }
        
        historyVCc = historyVC
        
        historyVCc?.delegate = self
        
    }
    
    
    func tabBarControllerSelectedIndex(selectedIndex: Int, calculate: Calculate?, number: ComplexNumber?) {
        self.selectedIndex = selectedIndex
        
        switch selectedIndex {
        case 0:
            guard let convertViewController = self.viewControllers?[0] as? ConvertViewController else { return }
            convertViewController.number = number
        case 1:
            guard let calculateViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CalculateViewController") as? CalculateViewController else { return }
        default:
            print("Error")
        }
//        self.tabBarController?.selectedIndex = selectedIndex
    }
    
    
    @IBAction func didPressQuestionButton(_ sender: UIButton) {
        self.selectedIndex = 1
    }
    
    @IBAction func didPressHistoryButton(_ sender: UIButton) {
        
//        let some: CustomTabBarIndexes?
        
//        guard let historyVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController else { return }
        
        guard let historyVCc = historyVCc else { return }

        let navigationC = UINavigationController()
//        navigationC.viewControllers = [historyVC]
        navigationC.viewControllers = [historyVCc]

        navigationC.navigationBar.prefersLargeTitles = true
        navigationC.navigationItem.largeTitleDisplayMode = .always
        
//        
//        historyVC.navigationController?.navigationBar.prefersLargeTitles = true
//        historyVC.navigationController?.navigationItem.largeTitleDisplayMode = .always
//        historyVC.navigationItem.largeTitleDisplayMode = .always
        
        
        present(navigationC, animated: true, completion: nil)
//        let navController = UINavigationController(rootViewController: historyVC)
//
//        self.navigationController?.present(navController, animated: true, completion: nil)
        
    }
    
}
