//
//  Screen.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit

//MARK: Screen dimensions

public struct Screen {
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    ///Iphone 5,5c,5s,6,6s,SE1,SE2,7,8 screen size
    static var isTiny: Bool {
        return UIScreen.main.nativeBounds.height == 1134 || UIScreen.main.nativeBounds.height == 1136
    }
 
}
