//
//  InformationViewController.swift
//  Calc
//
//  Created by Головаш Анастасия on 05.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let titles: [String] = ["Кнопки:", "Кнопка:", "Кнопка:"]
    let text: [String] = ["Змінюють знак числа у полі до якого вони відносяться.", "Змінює екзпоненційну на комплексну та навпаки.", "Переносить отриманий результат після конвертації до калькулятора."]
    let buttons: [UIButton] = [ChangeFormButton(), ChangeFormButton(), ChangeFormButton()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.945, green: 0.949, blue: 0.965, alpha: 1)
        setupTableView()
    }

    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InfoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "InfoTableViewCell")
    }
    
}


extension InformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? InfoTableViewCell else {
            return UITableViewCell() }
//        cell.button = buttons[indexPath.row]
        cell.titleLabel.text = titles[indexPath.row]
        cell.twoLinestextLabel.text = text[indexPath.row]
//        let btn = ChangeFormButton()
//        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        btn.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
//        btn.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor).isActive = true
//        cell.contentView.addSubview(btn)
        
        return cell
    }
    
    
}

