//
//  CurrentHourlySectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation


struct CurrentHourlySectionViewModel: SectionWithHeaderViewModel,SectionWithFooterViewModel {
    var count: Int {
        return 0
    }
    let headerViewModel: CurrentHeaderViewModel
    let footerViewModel : HourlyFooterVM
//    var headerViewModel: CurrentHeaderVM {
//
//        return CurrentHeaderVM(model: model)
//    }
//
//    var footerViewModel: HourlyFooterVM {
//
//        return HourlyFooterVM(model: model)
//    }
//
//    var model: Home.Weather.Response
//
//    init(model: Home.Weather.Response) {
//        self.model = model
//
//    }
}



struct HourlyFooterVM {
    
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
    
    
    let model: Home.Weather.Response
    
    init(model: Home.Weather.Response) {
        self.model = model
        
        
    }
    
    
}

struct HourlyItemViewModel {
    
    let model: Home.Weather.Current
    
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
            return temp.stringTemp
        }
        return "__"
    }
    
    init(model: Home.Weather.Current) {
        self.model = model
        
    }
    
}
