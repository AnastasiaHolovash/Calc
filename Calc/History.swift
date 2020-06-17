//
//  History.swift
//  Calc
//
//  Created by Головаш Анастасия on 15.06.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class History {
    
    static let shared = History()

    /// Array of 50 operations
    var resultHistory: [Operation] {
        get {
            if let data = UserDefaults.standard.data(forKey: "resultHistory") {
                let decoder = JSONDecoder()
                return (try? decoder.decode([Operation].self, from: data)) ?? []
            } else {
                return []
            }
        }
        set {
            if resultHistory.first != newValue.first {
                let encoder = JSONEncoder()
                var valueToSet = newValue
                
                if valueToSet.count > 50 {
                    valueToSet.removeLast()
                }
                let data = try? encoder.encode(valueToSet)
                UserDefaults.standard.set(data, forKey: "resultHistory")
            }
        }
    }
    
    /**
     Adds one operation to History
     - Parameter operation: operation to add
     */
    func addOperationToHistory(operation: Operation) {
        var allOperations = self.resultHistory
        print(allOperations)
        allOperations.insert(operation, at: 0)
        self.resultHistory = allOperations
    }
    
}
