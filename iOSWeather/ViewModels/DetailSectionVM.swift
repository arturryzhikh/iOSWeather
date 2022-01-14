//
//  DetailSectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import Foundation



struct DetailSectionVM:  ItemRepresentable, ModelInstantiable {
    
    typealias ItemViewModel = DetailCellVM
    
    var model: Forecast
    
    init(model: Forecast) {
        self.model = model
        
    }
    var items: [DetailCellVM] {
        
        var items: [DetailCellVM] = []
        for n in 0...8 {
            var item = DetailCellVM(model: model)
            item.item = n
            items.append(item)
        }
        return items
    }
    
    var numberOfItems: Int {
        return items.count
    }
    
}


struct DetailCellVM: ModelInstantiable {
    
    var item: Int = 0
    
    typealias DetailTuple = (detail: String, value: String)
    
    var detail: String  {
        let detail = getDetailFor(item: item)
        return detail.detail
        
    }
    
    var value: String  {
        let detail = getDetailFor(item: item)
        return detail.value
    }
    func getDetailFor(item: Int) -> DetailTuple {
        
        switch item {
        case 0:
            guard let sunrise = model.current?.sunrise else {
                return ("SUNRISE","--")
            }
            let sunriseDate = Date(timeIntervalSince1970: Double(sunrise))
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:MM"
            return  ("SUNRISE", formatter.string(from: sunriseDate))
            
        case 1:
            guard let sunset = model.current?.sunset else {
                return ("SUNSET","--")
            }
            let sunsetDate = Date(timeIntervalSince1970: Double(sunset))
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:MM"
            return  ("SUNSET", formatter.string(from: sunsetDate))
            
        case 2:
            guard let humidity = model.current?.humidity else {
                return ("HUMIDITY", "")
            }
            return ("HUMIDITY", "\(humidity)%")
        case 3:
            guard let windDeg = model.current?.windDeg,
                  let windSpeed = model.current?.windSpeed else {
                      return ("WIND", "")
                  }
            return ("WIND", "\(windDeg.windDirectionFromDegrees()) \(Int(windSpeed)) m/s")
        case 4:
            guard let feelsLike = model.current?.feelsLike else {
                return ("FEELS LIKE", "")
            }
            return ("FEELS LIKE", "\(feelsLike.stringTemperature)")
        case 5:
            guard let prec = model.minutely?.first?.precipitation else {
                return ("PRECIPITATION", "")
            }
            return ("PRECIPITATION", "\(Int(prec)) cm")
        case 6:
            guard let pressure = model.current?.pressure else {
                return ("PRESSURE", "")
            }
            let mmHgPressure = (Double(Double(pressure) / 1.333).rounded() * 100 / 100)
            
            return ("PRESSURE", "\(mmHgPressure) mm Hg")
        case 7:
            guard let visibility = model.current?.visibility else {
                return ("VISIBILITY", "")
            }
            return ("VISIBILITY", "\(visibility / 1000) km")
        case 8:
            guard let uv = model.current?.uvi else {
                return ("UV INDEX", "")
            }
            return ("UV INDEX", String(format: "%.0f", uv))
        default:
            return ("","")
        }
    }
    var model: Forecast
    
    init(model: Forecast) {
        self.model = model
    }
    
}
