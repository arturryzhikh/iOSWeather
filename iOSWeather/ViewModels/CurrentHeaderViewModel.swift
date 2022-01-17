//
//  CurrentHeaderVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 16.01.2022.
//



struct CurrentHeaderViewModel {
    
    let location: String
    let outline: String
    let temperature: String
    let temperatureRange: String
    
    init(location: String = .emptyString,
         outline: String = .emptyString,
         temperature: String = .emptyString,
         temperatureRange: String = .emptyString) {
        self.location = location
        self.outline = outline
        self.temperature = temperature
        self.temperatureRange = temperatureRange
    }
    
}

