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
    
    let sectionTitles = [
        NSLocalizedString("How to use?", comment: ""),
        NSLocalizedString("About complex numbers", comment: "")]
    
    let titlesForsection1: [String] = [
        NSLocalizedString("Buttons:", comment: ""),
        NSLocalizedString("Button:", comment: ""),
        NSLocalizedString("Button:", comment: "")]
    
    let titlesForsection2: [String] = [
        NSLocalizedString("Algebraic notation of a complex number", comment: ""),
        NSLocalizedString("Trigonometric notation of a complex number", comment: ""),
        NSLocalizedString("Complex number module:", comment: ""),
        NSLocalizedString("Exponential notation of a complex number", comment: ""),
        NSLocalizedString("The main argument", comment: ""),
        NSLocalizedString("Conjugate complex number", comment: ""),
        NSLocalizedString("Addition/subtraction of complex numbers", comment: ""),
        NSLocalizedString("Multiplication of complex numbers", comment: ""),
        NSLocalizedString("Division of complex numbers", comment: ""),
        NSLocalizedString("Elevation to the degree", comment: ""),
        NSLocalizedString("Calculating the root of degree n", comment: "")]
    
    let textForsection1: [String] = [
        NSLocalizedString("Change the sign of the number in the field to which they belong.", comment: ""),
        NSLocalizedString("Changes exponential to complex and vice versa.", comment: ""),
        NSLocalizedString("Transfers the result obtained after conversion to a calculator.", comment: "")]
    
    let textForsection2: [String] = [
        NSLocalizedString("where, i is an imaginary unit, a is a real part, bi is an imaginary part.", comment: ""),
        NSLocalizedString("where r is the modulus of the complex number, 𝝋 is the angle of inclination of the vector 0-z to the axis of real values or the argument of the complex number.", comment: ""),
        NSLocalizedString("corresponds to the distance from a point on the complex plane to the origin.", comment: ""),
        NSLocalizedString("(is an abbreviation of trigonometric form)", comment: ""),
        NSLocalizedString("The main argument is the value of the argument in the range (-π..π]", comment: "")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Information", comment: "")
        tableView.backgroundColor = mainBackgroundColor
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

