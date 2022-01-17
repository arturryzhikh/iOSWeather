//
//  DailyCellViewModel.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import Foundation


struct DailyCellViewModel {
    init(day: String = .emptyString,
         maxTemperature: String = .emptyString,
         minTemperature: String,
         weatherEmoji: String = .emptyString,
         probability: String = .emptyString) {
        self.day = day
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.weatherEmoji = weatherEmoji
        self.probability = probability
    }
    
    let day: String
    let maxTemperature: String
    let minTemperature: String
    let weatherEmoji: String
    let probability: String

}
