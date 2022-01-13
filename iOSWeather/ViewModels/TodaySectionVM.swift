//
//  TodaySectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation



struct TodaySectionVM:  ItemRepresentable , ModelInstantiable {
    
    var model: WeatherResponse
    
    var numberOfItems: Int {
        return items.count
    }
    
    var items: [TodayCellVM] {
        var returnValue: [TodayCellVM] = []
        returnValue.append(TodayCellVM(model: model))
        return returnValue
    }
    
    init(model: WeatherResponse) {
        self.model = model
        
    }
    
    
}

struct TodayCellVM: ModelInstantiable {
    
    var overview: String {
        if let highTemp = model.daily?.first?.temp?.max,
           let lowTemp = model.daily?.first?.temp?.min,
           let description = model.current?.weather?.first?.main?.rawValue {
            return """
            Today: \(description) currently. The high will be \(highTemp.stringTemperature). The low tonight will be \(lowTemp.stringTemperature)
            """
        }
        return ""
    }
    
    var model: WeatherResponse
    
    init(model: WeatherResponse) {
        self.model = model
    }
    
}
