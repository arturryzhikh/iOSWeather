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
    
    let model: Home.Responses.Response
    
    init(model: Home.Responses.Response) {
        self.model = model
    }
    func buildViewModel() -> Home.ViewModels.ViewModel {
        let current = buildCurrentHourlySectionViewModel()
        let daily = buildDailySectionViewModel()
        let today = buildTodaySectionViewModel()
        let detail = buildDetailSectionViewModel()
        let link = buildLinkSectionViewModel()
        return Home.ViewModels.ViewModel(
            currentHourlySectionVM: current,
            dailySectionVM: daily,
            todaySectionVM: today,
            detailSectionVM: detail,
            linkSectionVM: link)
    }
    //MARK: Current Hoyrly Section
    private func buildCurrentHourlySectionViewModel() -> Home.ViewModels.CurrentHourlySectionViewModel {
        let header = buildCurrentHeaderViewModel()
        let footer = buildHourlyFooterViewModel()
        return Home.ViewModels.CurrentHourlySectionViewModel(
            headerViewModel: header,
            footerViewModel: footer)
    }
    private func buildCurrentHeaderViewModel() -> Home.ViewModels.CurrentHeaderViewModel {
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
                return temperatureString(temperature: temp)
            }
            return .emptyString
        }
        
        var temperatureRange: String {
            if let highTemp = model.daily?.first?.temp?.max,
               let lowTemp = model.daily?.first?.temp?.min {
                return "High: \(temperatureString(temperature: highTemp))   Low: \(temperatureString(temperature: lowTemp))"
            }
            return .emptyString
            
        }
        return Home.ViewModels.CurrentHeaderViewModel(
            location: location,
            outline: outline,
            temperature: temperature,
            temperatureRange: temperatureRange)
    }
    
    
    private func buildHourlyFooterViewModel() -> Home.ViewModels.HourlyFooterViewModel {
        let items = model.hourly?.map { current in
            buildHourlyItemViewModel(model: current)
        } ?? []
        return Home.ViewModels.HourlyFooterViewModel(itemViewModels: items)
        
    }
    private func buildHourlyItemViewModel(model: Home.Responses.Current) -> Home.ViewModels.HourlyItemViewModel {
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
            return model.weather?.first?.icon ?? "))))))))"
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
                return temperatureString(temperature: temp)
            }
            return .emptyString
        }
        return Home.ViewModels.HourlyItemViewModel(
            hour: hour,
            weatherEmoji: weatherEmoji,
            temperature: temperature)
    }
    //MARK: Daily Section
    private func buildDailySectionViewModel() -> Home.ViewModels.DailySectionViewModel {
        let items = model.daily?.compactMap { daily in
            return buildDailyCellViewModel(model: daily)
            
        } ?? []
        return Home.ViewModels.DailySectionViewModel(itemViewModels: items)
    }
    
    private func buildDailyCellViewModel(model: Home.Responses.Daily) -> Home.ViewModels.DailyCellViewModel {
        
        var day: String {
            guard  let dt = model.dt else {
                return "--"
            }
            let date = Date(timeIntervalSince1970: Double(dt))
            return date.stringFromDate(dateFormat: "EEEE")
            
        }
        var maxTemperature: String {
            guard let high = model.temp?.max else {
                return .emptyString
            }
            return temperatureString(temperature: high)
        }
        var minTemperature: String {
            guard let low = model.temp?.min else {
                return .emptyString
            }
            return temperatureString(temperature: low)
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
        var probability: String {
            guard let prob = model.pop else {
                return "--"
            }
            let percentage = Int(prob * 100)
            return String(percentage) + "%"
        }
        return Home.ViewModels.DailyCellViewModel(
            day: day,
            maxTemperature: maxTemperature,
            minTemperature: minTemperature,
            weatherEmoji: weatherEmoji,
            probability: probability)
        
    }
    //MARK: Detail Section
    private func buildDetailSectionViewModel() -> Home.ViewModels.DetailSectionViewModel {
        var itemViewModels: [Home.ViewModels.DetailCellViewModel] {
            var items: [Home.ViewModels.DetailCellViewModel] = []
            for number in 0...8 {
                let vm = buildDetailCellViewModel(item: number)
                items.append(vm)
            }
            return items
        }
        return Home.ViewModels.DetailSectionViewModel(itemViewModels: itemViewModels)
        
    }
    
    private func buildDetailCellViewModel(item: Int) -> Home.ViewModels.DetailCellViewModel {
        var detail: (title: String, value: String) {
            switch item {
            case 0:
                guard let sunrise = model.current?.sunrise else {
                    return (.emptyString,.emptyString)
                }
                let sunriseDate = Date(timeIntervalSince1970: Double(sunrise))
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:MM"
                return  ("SUNRISE", formatter.string(from: sunriseDate))
                
            case 1:
                guard let sunset = model.current?.sunset else {
                    return (.emptyString,.emptyString)
                }
                let sunsetDate = Date(timeIntervalSince1970: Double(sunset))
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:MM"
                return  ("SUNSET", formatter.string(from: sunsetDate))
                
            case 2:
                guard let humidity = model.current?.humidity else {
                    return ("HUMIDITY", .emptyString)
                }
                return ("HUMIDITY", "\(humidity)%")
            case 3:
                guard let windDeg = model.current?.windDeg,
                      let windSpeed = model.current?.windSpeed else {
                          return ("WIND", .emptyString)
                      }
                return ("WIND", "\(windDirection(degree: windDeg)) \(Int(windSpeed)) m/s")
            case 4:
                guard let feelsLike = model.current?.feelsLike else {
                    return ("FEELS LIKE", .emptyString)
                }
                return ("FEELS LIKE", temperatureString(temperature: feelsLike))
            case 5:
                guard let prec = model.minutely?.first?.precipitation else {
                    return (.emptyString,.emptyString)
                }
                return ("PRECIPITATION", "\(Int(prec)) cm")
            case 6:
                guard let pressure = model.current?.pressure else {
                    return (.emptyString,.emptyString)
                }
                let mmHgPressure = (Double(Double(pressure) / 1.333).rounded() * 100 / 100)
                
                return ("PRESSURE", "\(mmHgPressure) mm Hg")
            case 7:
                guard let visibility = model.current?.visibility else {
                    return (.emptyString,.emptyString)
                }
                return ("VISIBILITY", "\(visibility / 1000) km")
            case 8:
                guard let uv = model.current?.uvi else {
                    return (.emptyString,.emptyString)
                }
                return ("UV INDEX", String(format: "%.0f", uv))
            default:
                return (.emptyString,.emptyString)
            }
        }
        return Home.ViewModels.DetailCellViewModel(
            title: detail.title,
            value: detail.value
        )
    }
    //MARK: Today Section
    private func buildTodaySectionViewModel() -> Home.ViewModels.TodaySectionViewModel {
        let item = buildTodayCellViewModel()
        return Home.ViewModels.TodaySectionViewModel(itemViewModels: [item])
    }
    
    private func buildTodayCellViewModel() -> Home.ViewModels.TodayCellViewModel {
        var overview: String {
            if let highTemp = model.daily?.first?.temp?.max,
               let lowTemp = model.daily?.first?.temp?.min,
               let description = model.current?.weather?.first?.description {
                return """
                Today: \(description) currently. The high will be \(temperatureString(temperature: highTemp)). The low tonight will be \(temperatureString(temperature: lowTemp))
                """
            }
            return .emptyString
        }
        return Home.ViewModels.TodayCellViewModel(overview: overview)
        
    }
    //MARK: Link Section
    private func buildLinkSectionViewModel() -> Home.ViewModels.LinkSectionViewModel {
        let item = buildLinkCellViewModel()
        return Home.ViewModels.LinkSectionViewModel(itemViewModels: [item])
    }
    private func buildLinkCellViewModel() -> Home.ViewModels.LinkCellViewModel {
        var link: NSMutableAttributedString {
            guard let timezone = model.timezone else {
                return NSMutableAttributedString()
            }
            let location = timezone.components(separatedBy: "/")[1]
                .replacingOccurrences(of: "_", with: " ")
            let attrSting = NSMutableAttributedString(string: "Weather for \(location). Thanks to Open Weather Map!")
            return attrSting
        }
        return Home.ViewModels.LinkCellViewModel(link: link)
    }
    
}

extension ViewModelBuilder {
    ///Converts wind degrees into wind direction code
    private func windDirection(degree: Int) -> String {
        
        let directions = ["N", "NNE", "NE", "ENE",
                          "E", "ESE", "SE", "SSE",
                          "S", "SSW", "SW", "WSW",
                          "W", "WNW", "NW", "NNW"]
        
        let i = Int((Double(degree) + 11.25)/22.5)
        
        return directions[i % 16]
    }
    ///Constructs temperature string from double
    private func temperatureString(temperature: Double) -> String {
        let degree = "°"
        if temperature > -1 && temperature < 0  {
            return "0" + degree
        } else {
            return String(format: "%.0f", temperature) + degree
        }
        
    }
}
