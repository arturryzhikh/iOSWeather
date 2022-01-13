//
//  AppDelegate.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit

extension UIFont {
    class var locationLabel: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.04), weight: .medium)

    }
    class var lightTemperature: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.025), weight: .light)
    }
    class var regularTemperature: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.025), weight: .regular)
    }
    class var hugeTemperature: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.08), weight: .light)
     
    }
    class var degree: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.03),weight: .light)
    }
    class var overView: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.022), weight: .light)
    }
    class var weatherEmoji: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.03), weight: .light)
    }
    class var extendedInfoTitle: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.02), weight: .light)
        
    }
    class var extendedInfoValue: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.032), weight: .regular)
        
    }
    
}
