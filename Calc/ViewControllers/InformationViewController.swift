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
    
    let titles: [String] = ["Кнопки:",
                            "Кнопка:",
                            "Кнопка:",
                            "Алгебраїчний запис комплексного числа",
                            "Тригонометричний запис комплексного числа",
                            "Модуль комплексного числа:",
                            "Показниковий запис комплексного числа",
                            "Головний аргумент",
                            "Спряжене комплексне число",
                            "Додавання/віднімання комплексних чисел",
                            "Множення комплексних чисел",
                            "Ділення комплексних чисел",
                            "Піднесення до степеня",
                            "Обчислення кореня степеня n"]
    
    let text: [String] = ["Змінюють знак числа у полі до якого вони відносяться.",
                          "Змінює екзпоненційну на комплексну та навпаки.",
                          "Переносить отриманий результат після конвертації до калькулятора.",
                          "де, i - уявна одиниця, a - дійсна частина, bi - уявна частина.",
                          "де r - модуль комплексного числа, 𝝋 - кут нахилу вектора 0-z до осі дійсних значень або аргумент комплексного числа.",
                          "відповідає відстані від точки на комплексній площині до початку координат.",
                          "(є скороченням тригонометричного запису)",
                          "Головний аргумент - це значення аргументу, що лежить в діапазоні (-π..π]"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Як користуватися?"
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.945, green: 0.949, blue: 0.965, alpha: 1)
        setupTableView()
    }

    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InfoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "InfoTableViewCell")
        tableView.register(UINib(nibName: "InfoTableViewCell2", bundle: Bundle.main), forCellReuseIdentifier: "InfoTableViewCell2")
        tableView.register(UINib(nibName: "InfoTableViewCell3", bundle: Bundle.main), forCellReuseIdentifier: "InfoTableViewCell3")
    }
    
    
    @IBAction func didPressCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}


extension InformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 3 || indexPath.row > 7 {
            return 155
        } else {
            return 175
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0...2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? InfoTableViewCell else {
                        return UITableViewCell() }
            cell.titleLabel.text = titles[indexPath.row]
            cell.twoLinestextLabel.text = text[indexPath.row]
            cell.infoImageView.image = UIImage(named: "Button-Image-\(indexPath.row)")
            return cell
        case 3...7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell2", for: indexPath) as? InfoTableViewCell2 else {
                        return UITableViewCell() }
            cell.titleLable.text = titles[indexPath.row]
            cell.otherTextLabel.text = text[indexPath.row]
            cell.formulaImageView.image = UIImage(named: "Info-Image-\(indexPath.row)")
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell3", for: indexPath) as? InfoTableViewCell3 else {
                        return UITableViewCell() }
            cell.titleLabel.text = titles[indexPath.row]
            cell.infoImageView.image = UIImage(named: "Info-Image-\(indexPath.row)")
            return cell
        }
        
        
    }
    
    
}

