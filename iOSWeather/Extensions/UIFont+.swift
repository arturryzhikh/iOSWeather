//
//  UIFont+WeatherFonts.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit

extension UIFont {
    
    static var locationLabel: UIFont {
        
        UIFont.systemFont(ofSize: (Screen.height * 0.04), weight: .medium)
        
    }
    
    static var lightTemperature: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.025), weight: .light)
    }
    static var regularTemperature: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.025), weight: .regular)
    }
    static var hugeTemperature: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.08), weight: .light)
        
    }
    static var degree: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.03),weight: .light)
    }
    static var overView: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.022), weight: .light)
    }
    static var weatherEmoji: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.03), weight: .light)
    }
    static var extendedInfoTitle: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.02), weight: .light)
        
    }
    static var extendedInfoValue: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.032), weight: .regular)
        
    }
    
}