//
//  AppDelegate.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

///enum that defines separator position in Clear Cell
enum SeparatorPosition {
    case bottom
    case top
}

extension ClearCell {
    func addSeparator(to position: SeparatorPosition, color: UIColor = .weatherTransparent,
                      of height: CGFloat = 0.75, aboveSubview: UIView) {
        guard self.contains(aboveSubview)  else {
            print("aboveSubview \(aboveSubview.description) is not added into view heiarchy. Try to add it first")
            return
        }
        let separator = UIView()
        separator.backgroundColor = color
        separator.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(separator, aboveSubview: aboveSubview)
        separator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: height).isActive = true
        if position == .top {
            separator.topAnchor.constraint(equalTo: topAnchor).isActive = true
        } else if position == .bottom {
            separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
    }
    
}
