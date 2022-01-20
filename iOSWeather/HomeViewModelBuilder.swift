//
//  ViewModelBuilder.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 15.01.2022.
//

import Foundation

protocol ViewModelBuilding {
    associatedtype V
    func buildViewModel() -> V
    func temperatureString(temperature: Double) -> String
}
extension ViewModelBuilding {
    ///Constructs temperature string from double
    func temperatureString(temperature: Double) -> String {
        if temperature > -1 && temperature < 0  {
            return "0" + .degree
        } else {
            return String(format: "%.0f", temperature) + .degree
        }
        
    }
}

public final class HomeViewModelBuilder: ViewModelBuilding {
    let model: Home.Responses.Response
    var placeName: String?
    init(model: Home.Responses.Response, placeName: String?) {
        self.model = model
        self.placeName = placeName
    }
    func buildViewModel() -> Home.ViewModels.ViewModel {
        let current = buildCurrentHourlySectionViewModel()
        let daily = buildDailySectionViewModel()
        let today = buildTodaySectionViewModel()
        let detail = buildDetailSectionViewModel()
        return Home.ViewModels.ViewModel(
            currentHourlySectionVM: current,
            dailySectionVM: daily,
            todaySectionVM: today,
            detailSectionVM: detail
            
        )
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
            if let placeName = placeName?.components(separatedBy: ",").first {
                return placeName
            }
            
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
        
        var IconName: String {
            if let icon = model.weather?.first?.icon {
                return icon + ".png"
            }
            return "01d.png"
            
        }
        var temperature: String {
            if let temp = model.temp {
                return temperatureString(temperature: temp)
            }
            return .emptyString
        }
        return Home.ViewModels.HourlyItemViewModel(
            hour: hour,
            iconName: IconName,
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
        var weatherIcon: String {
            if let icon = model.weather?.first?.icon {
                return icon + ".png"
            }
            return "01d.png"
            
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
            weatherIcon: weatherIcon,
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
                    return ("SUNRISE",.emptyString)
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
                let dir = "\(windDirection(degree: windDeg))"
                let speed = "\(Int(windSpeed)) m/s"
                return ("WIND", dir + .space + .space + speed)
            case 4:
                guard let feelsLike = model.current?.feelsLike else {
                    return ("FEELS LIKE", .emptyString)
                }
                return ("FEELS LIKE", temperatureString(temperature: feelsLike))
            case 5:
                guard let prec = model.minutely?.first?.precipitation else {
                    return ("PRECIPITATION",.emptyString)
                }
                return ("PRECIPITATION", "\(Int(prec)) cm")
            case 6:
                guard let pressure = model.current?.pressure else {
                    return ("PRESSURE",.emptyString)
                }
                let mmHgPressure = (Double(Double(pressure) / 1.333).rounded() * 100 / 100)
                
                return ("PRESSURE", "\(mmHgPressure) mm Hg")
            case 7:
                guard let visibility = model.current?.visibility else {
                    return ("VISIBILITY",.emptyString)
                }
                return ("VISIBILITY", "\(visibility / 1000) km")
            case 8:
                guard let uv = model.current?.uvi else {
                    return ("UV INDEX",.emptyString)
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
    
}

extension HomeViewModelBuilder {
    ///Converts wind degrees into wind direction code
    private func windDirection(degree: Int) -> String {
        let directions = ["N", "NNE", "NE", "ENE",
                          "E", "ESE", "SE", "SSE",
                          "S", "SSW", "SW", "WSW",
                          "W", "WNW", "NW", "NNW"]
        
        let i = Int((Double(degree) + 11.25)/22.5)
        
        return directions[i % 16]
    }
    
}
