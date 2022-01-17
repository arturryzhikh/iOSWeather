//
//  ViewModelBuilder.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 15.01.2022.
//

import Foundation

protocol ViewModelBuilding {
    associatedtype T
    func buildViewModel() -> T
}

public final class ViewModelBuilder: ViewModelBuilding {
    
    let model: Home.Weather.Response
    
    init(model: Home.Weather.Response) {
        self.model = model
    }
    func buildViewModel() -> Home.Weather.ViewModel {
        return Home.Weather.ViewModel()
    }
    private func buildCurrentHourlySectionViewModel() -> CurrentHourlySectionViewModel {
        let header = buildCurrentHeaderViewModel()
        let footer = buildHourlyFooterViewModel()
        return CurrentHourlySectionViewModel(
            headerViewModel: header,
            footerViewModel: footer)
    }
    private func buildCurrentHeaderViewModel() -> CurrentHeaderViewModel {
        var location: String {
            return model
                .timezone?
                .components(separatedBy: "/")[1]
                .replacingOccurrences(of: "_", with: " ") ?? .emptyString
        }
        
        var outline: String {
            return model
                .current?
                .weather?
                .first?
                .description ?? .emptyString
        }
        
        var temperature: String {
            if let temp = model.current?.temp {
                return temp.stringTemp
            }
            return .emptyString
        }
        
        var temperatureRange: String {
            if let highTemp = model.daily?.first?.temp?.max,
               let lowTemp = model.daily?.first?.temp?.min {
                return "High: \(highTemp.stringTemp)   Low: \(lowTemp.stringTemp)"
            }
            return .emptyString
            
        }
        return CurrentHeaderViewModel(
            location: location,
            outline: outline,
            temperature: temperature,
            temperatureRange: temperatureRange)
    }
    
    //Hourly Footer View Model
    private func buildHourlyFooterViewModel() -> HourlyFooterViewModel {
        let items = model.hourly?.map { current in
            buildHourlyItemViewModel(model: current)
        } ?? []
        return HourlyFooterViewModel(itemViewModels: items)
        
    }
    private func buildHourlyItemViewModel(model: Home.Weather.Current) -> HourlyItemViewModel {
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
        return HourlyItemViewModel(
            hour: hour,
            weatherEmoji: weatherEmoji,
            temperature: temperature)
    }
    private func buildDailySectionViewModel() -> DailySectionViewModel {
        let items = model.daily?.compactMap { daily in
            return buildDailyCellViewModel(model: daily)
            
        } ?? []
        return DailySectionViewModel(itemViewModels: items)
    }
    
    private func buildDailyCellViewModel(model: Home.Weather.Daily) -> DailyCellViewModel {
        
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
            return high.stringTemp
        }
        var temperatureLow: String {
            guard let low = model.temp?.min else {
                return "__"
            }
            return low.stringTemp
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
        return DailyCellViewModel(
            day: day,
            temperatureHigh: temperatureHigh,
            temperatureLow: temperatureLow,
            weatherEmoji: weatherEmoji,
            percentage: percentage)
        
    }
}
