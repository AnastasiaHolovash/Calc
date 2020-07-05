//
//  HistoryViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 10.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

enum CustomTabBarIndexes: Int {
    case convertViewController = 0
    case calculateViewController = 1
}


protocol TabBarIndexDelegate {
    func tabBarControllerSelectedIndex(selectedIndex: Int, calculate: Calculate?, number: ComplexNumber?)
}


class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tabBarIndexDelegate: TabBarIndexDelegate?
    
    var history = History.shared.resultHistory
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.945, green: 0.949, blue: 0.965, alpha: 1)
        setupTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        history = History.shared.resultHistory
        tableView.reloadData()
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    
    @IBAction func didPressCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell() }
        cell.setOperation(operation: history[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true) {
            switch self.history[indexPath.row] {
            case .convert(let complexNumber):
                self.tabBarIndexDelegate?.tabBarControllerSelectedIndex(selectedIndex: CustomTabBarIndexes.convertViewController.rawValue, calculate: nil, number: complexNumber )
            case .culculate(let calculate):
                self.tabBarIndexDelegate?.tabBarControllerSelectedIndex(selectedIndex: CustomTabBarIndexes.calculateViewController.rawValue, calculate: calculate, number: nil)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
}
