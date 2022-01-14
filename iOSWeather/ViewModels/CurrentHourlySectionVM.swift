//
//  CurrentHourlySectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation


struct CurrentHourlySectionVM: ModelInstantiable, HeaderRepresentable, FooterRepresentable {
    
    
    
    var numberOfItems: Int {
        return 0
    }
    
    var header: CurrentHeaderVM {
        
        return CurrentHeaderVM(model: model)
    }
    
    var footer: HourlyFooterVM {
        
        return FooterViewModel(model: model)
    }
    
    var model: Forecast
    
    init(model: Forecast) {
        self.model = model
        
    }
    
    
}

struct CurrentHeaderVM: ModelInstantiable {
    
    let model: Forecast
    
    var location: String {
        return model.timezone?.components(separatedBy: "/")[1].replacingOccurrences(of: "_", with: " ") ?? "__"
    }
    
    var outline: String {
        return model.current?.weather?.first?.description ?? "__"
    }
    
    var temperature: String {
        if let temp = model.current?.temp {
            return temp.stringTemperature
        }
        return "__"
    }
    var highLowTemp: String {
        
        if let highTemp = model.daily?.first?.temp?.max,
           let lowTemp = model.daily?.first?.temp?.min {
            return "High: \(highTemp.stringTemperature)   Low: \(lowTemp.stringTemperature)"
        }
        return "__"
        
    }
    init(model: Forecast) {
        self.model = model
        
    }
    
}


struct HourlyFooterVM: ModelInstantiable {
    
    var items: [HourlyItemViewModel]  {
        var returnValue: [HourlyItemViewModel]
        guard let hourly = model.hourly else {
            return []
        }
        returnValue =  hourly.compactMap {
            HourlyItemViewModel(model: $0)
            
        }
        return returnValue
    }
    
    
    let model: Forecast
    
    init(model: Forecast) {
        self.model = model
        
        
    }
    
    
}

struct HourlyItemViewModel: ModelInstantiable {
    
    let model: Current
    
    var hour: String  {
        guard let dt = model.dt else {
            return "--"
        }
        let hourlyDate = Date(timeIntervalSince1970: Double(dt))
        if Calendar.current.isDate(hourlyDate, equalTo: Date(), toGranularity: .day) &&
            Calendar.current.isDate(hourlyDate, equalTo: Date(), toGranularity: .hour) {
            return "Now"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: hourlyDate)
    }
    
    var weatherEmoji: String {
        
        return "Emoji"
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
    var temperature: String {
        if let temp = model.temp {
            return temp.stringTemperature
        }
        return "__"
    }
    
    init(model: Current) {
        self.model = model
        
    }
    
}
