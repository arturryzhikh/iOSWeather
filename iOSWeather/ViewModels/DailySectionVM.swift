//
//  DailySectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

struct DailySectionVM: ItemRepresentable, ModelInstantiable {
    
    
    var numberOfItems: Int {
        return items.count
    }
    
    var items: [DailyCellVM] {
        
        if let daily = model.daily {
            return daily.map {
                DailyCellVM(model: $0)
            }
        }
        return []
        
    }
    
    
    
    var model: Forecast
    
    init(model: Forecast) {
        self.model = model
        
    }
    
}


struct DailyCellVM: ModelInstantiable {
    
    var day: String {
        guard  let dt = model.dt else {
            return "--"
        }
        let date = Date(timeIntervalSince1970: Double(dt))
        return date.stringFromDate(dateFormat: "EEEE")
        
    }
    var temperatureHigh: String {
        guard let high = model.temp?.max else {
            return "__"
        }
        return high.stringTemperature
    }
    var temperatureLow: String {
        guard let low = model.temp?.min else {
            return "__"
        }
        return low.stringTemperature
    }
    var weatherEmoji: String {
        return "Description"
//        guard let description = model.weather?.first?.main else {
//            return "..."
//        }
//        switch description {
//            
//        case .clear:
//            return "☀️"
//        case .clouds:
//            return "☁️"
//        case .rain:
//            return "🌧"
//        case .snow:
//            return "❄️"
//        case .mist:
//            return "🌫"
//            
//        }
    }
    var percentage: String {
        guard let prob = model.pop else {
            return "--"
        }
        let probability = Int(prob * 100)
        return String(probability) + "%"
    }
    
    let model: Daily
    
    init(model: Daily) {
        self.model = model
        
    }
    
    
}
