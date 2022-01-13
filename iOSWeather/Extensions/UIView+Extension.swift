//
//  UIView+Extension.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

public extension UIView {
    /// Adds multiple UI Views as subviews
    ///
    /// - Parameters:
    ///     - subview: UI Views to add
    func addMultipleSubviews(_ subviews: UIView...) {
        subviews.forEach {
            self.addSubview($0)
        }
    }
    
    func addGradientBackground() {
        let random = UIColor.random().cgColor
        let random2 = UIColor.random().cgColor

        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [random, random2]

        layer.addSublayer(gradient)
    }
}

