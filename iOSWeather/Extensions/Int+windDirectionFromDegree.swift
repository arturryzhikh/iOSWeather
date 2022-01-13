//
//  AppDelegate.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

extension Int {
    func windDirectionFromDegrees() -> String {

        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i: Int = Int((Double(self) + 11.25)/22.5)
        return directions[i % 16]
    }
}
