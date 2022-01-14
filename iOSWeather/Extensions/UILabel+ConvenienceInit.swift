//
//  UILabel+ConvenienceInit.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

extension UILabel {
    
    convenience init(transparentText: Bool = false ,
                     alignment: NSTextAlignment = .center,
                     font: UIFont) {
        self.init()
        textColor = transparentText ? .weatherTransparent : .weatherWhite
        textAlignment = alignment
        numberOfLines = 1
        self.font = font
    }
}
