//
//  UserData.swift
//  Calc
//
//  Created by Головаш Анастасия on 29.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class UserData {
    
    static let shared = UserData()
    
    var wasLaunchedBefore: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "wasLaunchedBefore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wasLaunchedBefore")
        }
    }
}
