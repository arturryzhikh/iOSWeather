//
//  AppDelegate.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

extension Double  {
    
    var stringTemperature: String {
        
        if self > -1 && self < 0  {
            return "0°"
        } else {
            return String(format: "%.0f", self) + "°"
        }
        
    }
}

