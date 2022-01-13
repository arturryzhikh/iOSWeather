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
    
   
}


