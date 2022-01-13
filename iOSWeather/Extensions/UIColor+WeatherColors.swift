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
        return  #colorLiteral(red: 0, green: 0.5476340055, blue: 0.9840434194, alpha: 1)
    }
}
