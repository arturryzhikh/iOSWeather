//
//  UIColor+WeatherColors.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

extension UIColor {
    class var weatherWhite: UIColor {
        return .white
    }
    class var weatherTransparent: UIColor {
        return white.withAlphaComponent(0.75)
    }
    class var percentage: UIColor {
        return  #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
