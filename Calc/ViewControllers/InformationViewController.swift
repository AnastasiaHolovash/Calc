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
    
    let sectionTitles = ["Як користуватися?",
                         "Про комплексні числа"]
    
    let titlesForsection1: [String] = ["Кнопки:",
                                        "Кнопка:",
                                        "Кнопка:"]
    
    let titlesForsection2: [String] = ["Алгебраїчний запис комплексного числа",
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
    
    let textForsection1: [String] = ["Змінюють знак числа у полі до якого вони відносяться.",
                                     "Змінює екзпоненційну на комплексну та навпаки.",
                                     "Переносить отриманий результат після конвертації до калькулятора."]
    
    let textForsection2: [String] = ["де, i - уявна одиниця, a - дійсна частина, bi - уявна частина.",
                                     "де r - модуль комплексного числа, 𝝋 - кут нахилу вектора 0-z до осі дійсних значень або аргумент комплексного числа.",
                                     "відповідає відстані від точки на комплексній площині до початку координат.",
                                     "(є скороченням тригонометричного запису)",
                                     "Головний аргумент - це значення аргументу, що лежить в діапазоні (-π..π]"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Інформація"
        self.navigationController?.navigationBar.backgroundColor = mainBackgroundColor
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
        if section == 0 {
            return 3
        } else {
            return 9
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.row > 4 {
            return 155
        } else {
            return 175
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        returnedView.backgroundColor = mainBackgroundColor

        let label = UILabel(frame: CGRect(x: 25, y: 5, width: view.frame.size.width - 50, height: 25))
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = sectionTitles[section]

        returnedView.addSubview(label)
//        returnedView.addShadowForLabel()
        return returnedView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? InfoTableViewCell else {
                        return UITableViewCell() }
            cell.titleLabel.text = titlesForsection1[indexPath.row]
            cell.twoLinestextLabel.text = textForsection1[indexPath.row]
            cell.infoImageView.image = UIImage(named: "Button-Image-\(indexPath.row)")
            return cell
        
        } else {
            switch indexPath.row {
            case 0...4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell2", for: indexPath) as? InfoTableViewCell2 else {
                            return UITableViewCell() }
                cell.titleLable.text = titlesForsection2[indexPath.row]
                cell.otherTextLabel.text = textForsection2[indexPath.row]
                cell.formulaImageView.image = UIImage(named: "Info-Image-\(indexPath.row)")
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell3", for: indexPath) as? InfoTableViewCell3 else {
                            return UITableViewCell() }
                cell.titleLabel.text = titlesForsection2[indexPath.row]
                cell.infoImageView.image = UIImage(named: "Info-Image-\(indexPath.row)")
                return cell
            }
        }
    }
    
    
}

