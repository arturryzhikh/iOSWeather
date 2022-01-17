//
//  File.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import Foundation

struct HourlyItemViewModel {
    init(hour: String = .emptyString,
         weatherEmoji: String = .emptyString,
         temperature: String = .emptyString) {
        self.hour = hour
        self.weatherEmoji = weatherEmoji
        self.temperature = temperature
    }
    let hour: String
    let weatherEmoji: String
    let temperature: String

}
