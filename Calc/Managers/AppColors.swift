//
//  Colors.swift
//  Calc
//
//  Created by Головаш Анастасия on 08.07.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit


public var mainBackgroundColor: UIColor = {
    if #available(iOS 13, *) {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor.black
            } else {
                /// Return the color for Light Mode
                return UIColor.tertiarySystemGroupedBackground
            }
        }
    } else {
        /// Return a fallback color for iOS 12 and lower.
        return UIColor(red: 0.945, green: 0.949, blue: 0.965, alpha: 1)
    }
}()


public var infoPresentBackgroundColor: UIColor = {
    if #available(iOS 13, *) {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor.systemGray5
            } else {
                /// Return the color for Light Mode
                return UIColor.white
            }
        }
    } else {
        /// Return a fallback color for iOS 12 and lower.
        return UIColor.white
    }
}()


public var shadowColor: UIColor = {
    if #available(iOS 13, *) {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor.systemGray
//                return UIColor.black
//                return UIColor.systemGray2
            } else {
                /// Return the color for Light Mode
                return UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
            }
        }
    } else {
        /// Return a fallback color for iOS 12 and lower.
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    }
}()

