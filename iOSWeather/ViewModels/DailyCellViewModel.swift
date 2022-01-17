//
//  DailyCellViewModel.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import Foundation


struct DailyCellViewModel {
    init(day: String = .emptyString,
         temperatureHigh: String = .emptyString,
         temperatureLow: String,
         weatherEmoji: String = .emptyString,
         percentage: String = .emptyString) {
        self.day = day
        self.temperatureHigh = temperatureHigh
        self.temperatureLow = temperatureLow
        self.weatherEmoji = weatherEmoji
        self.percentage = percentage
    }
    
    let day: String
    let temperatureHigh: String
    let temperatureLow: String
    let weatherEmoji: String
    let percentage: String

}
