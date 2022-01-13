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
 
}
