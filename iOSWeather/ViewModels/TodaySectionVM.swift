//
//  TodaySectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation



struct TodaySectionVM:  ItemRepresentable {
    
    var model: Home.Weather.Response
    
    var numberOfItems: Int {
        return items.count
    }
    
    var items: [TodayCellVM] {
        var returnValue: [TodayCellVM] = []
        returnValue.append(TodayCellVM(model: model))
        return returnValue
    }
    
    init(model: Home.Weather.Response) {
        self.model = model
        
    }
    
    
}

struct TodayCellVM {
    
    var overview: String {
        if let highTemp = model.daily?.first?.temp?.max,
           let lowTemp = model.daily?.first?.temp?.min,
           let description = model.current?.weather?.first?.main {
            return """
            Today: \(description) currently. The high will be \(highTemp.stringTemp). The low tonight will be \(lowTemp.stringTemp)
            """
        }
        return ""
    }
    
    var model: Home.Weather.Response
    
    init(model: Home.Weather.Response) {
        self.model = model
    }
    
}
