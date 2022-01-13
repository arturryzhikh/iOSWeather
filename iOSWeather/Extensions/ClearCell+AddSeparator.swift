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
        separator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
            switch position {
            case .top:
                make.top.equalToSuperview()
            case .bottom:
                make.bottom.equalToSuperview()
            }
            
        }
    
    }
}
