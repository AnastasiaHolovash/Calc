//
//  HistoryViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 10.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let history = History.shared.resultHistory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CustomTableViewCell")
        
//        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//        tableView.insetsContentViewsToSafeArea = false
    }
    
    @IBAction func didPressCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            // Show other VC
        }
    }
    

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell() }
        
        var text = ""
        switch history[indexPath.row] {
        case .convert(let complexNumber):
            text += "\(complexNumber.part1)  \(complexNumber.part2)"
        case .culculate(let calculate):
            text += ""
        }
        
        cell.operationLabel.text = text
        return cell
    }
    
    
    
}
