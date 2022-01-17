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
        let current = buildCurrentHourlySectionViewModel()
        let daily = buildDailySectionViewModel()
        let today = buildTodaySectionViewModel()
        let detail = buildDetailSectionViewModel()
        let link = buildLinkSectionViewModel()
        return Home.Weather.ViewModel(
            currentHourlySectionVM: current,
            dailySectionVM: daily,
            todaySectionVM: today,
            detailSectionVM: detail,
            linkSectionVM: link)
    }
    //MARK: Current Hoyrly Section
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
    //MARK: Daily Section
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
        var maxTemperature: String {
            guard let high = model.temp?.max else {
                return "__"
            }
            return high.stringTemp
        }
        var minTemperature: String {
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
        var probability: String {
            guard let prob = model.pop else {
                return "--"
            }
            let percentage = Int(prob * 100)
            return String(percentage) + "%"
        }
        return DailyCellViewModel(
            day: day,
            maxTemperature: maxTemperature,
            minTemperature: minTemperature,
            weatherEmoji: weatherEmoji,
            probability: probability)
        
    }
    //MARK: Detail Section
    private func buildDetailSectionViewModel() -> DetailSectionViewModel {
        var itemViewModels: [DetailCellViewModel] {
            var items: [DetailCellViewModel] = []
            for number in 0...8 {
                let vm = buildDetailCellViewModel(item: number)
                items.append(vm)
            }
            return items
        }
        return DetailSectionViewModel(itemViewModels: itemViewModels)
        
    }
    
    private func buildDetailCellViewModel(item: Int) -> DetailCellViewModel {
        var detail: (title: String, value: String) {
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
                return ("FEELS LIKE", "\(feelsLike.stringTemp)")
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
        return DetailCellViewModel(
            title: detail.title,
            value: detail.value
        )
    }
    //MARK: Today Section
    private func buildTodaySectionViewModel() -> TodaySectionViewModel {
        let item = buildTodayCellViewModel()
        return TodaySectionViewModel(itemViewModels: [item])
    }
    private func buildTodayCellViewModel() -> TodayCellViewModel {
        var overview: String {
            if let highTemp = model.daily?.first?.temp?.max,
               let lowTemp = model.daily?.first?.temp?.min,
               let description = model.current?.weather?.first?.description {
                return """
                Today: \(description) currently. The high will be \(highTemp.stringTemp). The low tonight will be \(lowTemp.stringTemp)
                """
            }
            return .emptyString
        }
        return TodayCellViewModel(overview: overview)
        
    }
    //MARK: Link Section
    private func buildLinkSectionViewModel() -> LinkSectionViewModel {
        let item = buildLinkCellViewModel()
        return LinkSectionViewModel(itemViewModels: [item])
    }
    private func buildLinkCellViewModel() -> LinkCellViewModel {
        var link: NSMutableAttributedString {
            guard let timezone = model.timezone else {
                return NSMutableAttributedString()
            }
            let location = timezone.components(separatedBy: "/")[1]
                .replacingOccurrences(of: "_", with: " ")
            let attrSting = NSMutableAttributedString(string: "Weather for \(location). Thanks to Open Weather Map!")
            return attrSting
        }
        return LinkCellViewModel(link: link)
    }
    
}
