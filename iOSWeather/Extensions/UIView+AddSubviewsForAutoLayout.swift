//
//  AppDelegate.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

public extension UIView {
    /// Adds individual UIView as subview, set it's translateAutoResizingMaskIntoConstraints property to false
    ///
    /// - Parameters:
    ///     - subview: UIView to add
    func addSubviewForAutoLayout(_ subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(subview)
    }
    /// Adds multiple UIViews as subviews, set their translateAutoResizingMaskIntoConstraints property to false
    ///
    /// - Parameters:
    ///     - subview: UIViews to add
    func addSubviewsForAutoLayout(_ subviews: [UIView]) {
        subviews.forEach(addSubviewForAutoLayout)
    }
}


