//
//  CustomTapBarController.swift
//  Calc
//
//  Created by Головаш Анастасия on 17.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class CustomTapBarController: UITabBarController {
    
    @IBAction func didPressHistoryButton(_ sender: UIButton) {
        
        guard let historyVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController else { return }

        let navigationC = UINavigationController()
        navigationC.viewControllers = [historyVC]

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
