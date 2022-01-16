//
//  CurrentHeaderVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 16.01.2022.
//



struct CurrentHeaderViewModel {
  
    var location: String = .emptyString
    var outline: String = .emptyString
    var temperature: String = .emptyString
    var temperatureRange: String = .emptyString
    
    init(location: String,
         outline: String,
         temperature: String,
         temperatureRange: String) {
        self.location = location
        self.outline = outline
        self.temperature = temperature
        self.temperatureRange = temperatureRange
    }
    
 }
