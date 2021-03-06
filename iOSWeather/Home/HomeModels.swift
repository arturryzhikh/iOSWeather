//
//  HomeModels.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 14.01.2022.
//  Copyright (c) 2022 Artur Ryzhikh. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SectionWithItemsViewModel {
    associatedtype CellViewModel
    var itemViewModels: [CellViewModel] { get }
    var count: Int { get }
    func item(at index: Int) -> CellViewModel?
    
}

extension SectionWithItemsViewModel {
    func item(at index: Int) -> CellViewModel? {
        return itemViewModels[index]
    }
    var count: Int {
        return itemViewModels.count
    }
}


public protocol SectionWithHeaderViewModel {
    associatedtype headerViewModel
    var headerViewModel: headerViewModel  { get }
    var count: Int {  get }
}


public protocol SectionWithFooterViewModel {
    associatedtype FooterViewModel
    var footerViewModel: FooterViewModel { get  }
    var count: Int { get }
}

enum Home {
    //MARK: Requests
    enum Requests {
        struct Request: NetworkRequest {
            var url: String {
                return Api.OpenWeatherMap.oneCallEndpoint
            }
            var httpMethod: HTTPMethod = .get
            typealias NetworkResponse = Home.Responses.Response
            var queries: [String : String] = [
                "exclude" :  "alerts",
                "lang" : "en",
                "units" : "metric",
                "appid" : Api.OpenWeatherMap.key
            ]
            
            init (lat: String,
                  lon: String) {
                queries.updateValue(lat, forKey: "lat")
                queries.updateValue(lon, forKey: "lon")
            }
            
        }
        
    }
    // MARK: Responses
    enum Responses {
        struct Response: Codable {
            let lat, lon: Double?
            let timezone: String?
            let timezoneOffset: Int?
            let current: Current?
            let minutely: [Minutely]?
            let hourly: [Current]?
            let daily: [Daily]?
        }
        
        // MARK: - Current
        struct Current: Codable {
            let dt, sunrise, sunset: Int?
            let temp, feelsLike: Double?
            let pressure, humidity: Int?
            let dewPoint, uvi: Double?
            let clouds, visibility: Int?
            let windSpeed: Double?
            let windDeg: Int?
            let weather: [Weather]?
            let pop: Double?
        }
        
        
        // MARK: - Weather
        struct Weather: Codable {
            let id: Int
            let main: String
            let icon: String
            let description: String
        }
        
        // MARK: - Daily
        struct Daily: Codable {
            let dt, sunrise, sunset: Int?
            let temp: Temp?
            let feelsLike: FeelsLike?
            let pressure, humidity: Int?
            let dewPoint, windSpeed: Double?
            let windDeg: Int?
            let weather: [Weather]?
            let clouds: Int?
            let pop, snow, uvi: Double?
            
        }
        
        // MARK: - FeelsLike
        struct FeelsLike: Codable {
            let day, night, eve, morn: Double?
        }
        
        // MARK: - Temp
        struct Temp: Codable {
            let day, min, max, night: Double?
            let eve, morn: Double?
        }
        
        // MARK: - Minutely
        struct Minutely: Codable {
            let dt: Int?
            let precipitation: Double?
        }
        
    }
    //MARK: ViewModels
    enum ViewModels {
        struct ViewModel {
            enum Section: Int {
                case currentHourly,
                     daily,
                     today,
                     detail
            }
            
            init(currentHourlySectionVM: CurrentHourlySectionViewModel = CurrentHourlySectionViewModel.init(),
                 dailySectionVM: DailySectionViewModel = DailySectionViewModel.init(),
                 todaySectionVM: TodaySectionViewModel = .init(),
                 detailSectionVM: DetailSectionViewModel = .init()
            ) {
                self.currentHourlySectionVM = currentHourlySectionVM
                self.dailySectionVM = dailySectionVM
                self.todaySectionVM = todaySectionVM
                self.detailSectionVM = detailSectionVM
                
            }
            
            //MARK: Section View Models
            var currentHourlySectionVM: CurrentHourlySectionViewModel
            var dailySectionVM: DailySectionViewModel
            var todaySectionVM: TodaySectionViewModel
            var detailSectionVM: DetailSectionViewModel
            
            //MARK: Properties
            
            var sections: [Int] = [
                Section.currentHourly.rawValue,
                Section.daily.rawValue,
                Section.today.rawValue,
                Section.detail.rawValue,
            ]
            
            var numberOfSections: Int {
                return sections.count
            }
            
            func numberOfItemsIn(_ section: Int) -> Int {
                
                switch Section(rawValue: section) {
                    
                case .currentHourly:
                    return currentHourlySectionVM.count
                    
                case .daily:
                    return dailySectionVM.count
                    
                case .today:
                    return todaySectionVM.count
                    
                case .detail:
                    return detailSectionVM.count
                    
                default:
                    return 0
                }
            }
            
        }
        
        //MARK: CurrentHourlySectionViewModel
        struct CurrentHourlySectionViewModel: SectionWithHeaderViewModel, SectionWithFooterViewModel {
            
            init(headerViewModel: CurrentHeaderViewModel = .init(),
                 footerViewModel: HourlyFooterViewModel = .init()) {
                self.headerViewModel = headerViewModel
                self.footerViewModel = footerViewModel
            }
            
            var count: Int {
                return 0
            }
            let headerViewModel: CurrentHeaderViewModel
            let footerViewModel : HourlyFooterViewModel
        }
        //MARK: CurrentHeaderViewModel
        struct CurrentHeaderViewModel {
            
            let location: String
            let outline: String
            let temperature: String
            let temperatureRange: String
            
            init(location: String = .emptyString,
                 outline: String = .emptyString,
                 temperature: String = .emptyString ,
                 temperatureRange: String = .emptyString) {
                self.location = location
                self.outline = outline
                self.temperature = temperature
                self.temperatureRange = temperatureRange
            }
            
        }
        
        //MARK: HourlyFooterViewModel
        struct HourlyFooterViewModel: SectionWithItemsViewModel {
            
            init(itemViewModels: [HourlyItemViewModel] = []) {
                self.itemViewModels = itemViewModels
            }
            
            let itemViewModels: [HourlyItemViewModel]
            
        }
        //MARK: HourlyItemViewModel
        struct HourlyItemViewModel {
            
            init(hour: String = .emptyString,
                 iconName: String = .emptyString,
                 temperature: String = .emptyString) {
                self.hour = (hour == .emptyString) ? .underScore : hour
                self.iconName = iconName
                self.temperature = (temperature == .emptyString) ? (.underScore + .degree) : temperature
            }
            
            let hour: String
            let iconName: String
            let temperature: String
            
        }
        //MARK: DailySectionViewModel
        struct DailySectionViewModel: SectionWithItemsViewModel {
            init(itemViewModels: [DailyCellViewModel] = []) {
                self.itemViewModels = itemViewModels
            }
            
            let itemViewModels: [DailyCellViewModel]
            
        }
        //MARK: DailyCellViewModel
        
        struct DailyCellViewModel {
            init(day: String = .emptyString,
                 maxTemperature: String = .emptyString,
                 minTemperature: String,
                 weatherIcon: String = .emptyString,
                 probability: String = .emptyString) {
                self.day = day
                self.maxTemperature = maxTemperature
                self.minTemperature = minTemperature
                self.weatherIcon = weatherIcon
                self.probability = probability
            }
            
            let day: String
            let maxTemperature: String
            let minTemperature: String
            let weatherIcon: String
            let probability: String
            
        }
        
        //MARK: DetailSectionViewModel
        struct DetailSectionViewModel: SectionWithItemsViewModel {
            init(itemViewModels: [DetailCellViewModel] = []) {
                self.itemViewModels = itemViewModels
            }
            let itemViewModels: [DetailCellViewModel]
            
        }
        //MARK: DetailCellViewModel
        struct DetailCellViewModel {
            init(title: String = .emptyString,
                 value: String = .emptyString) {
                self.title = title
                self.value = value
            }
            let title: String
            let value: String
        }
        //MARK: TodaySectionViewModel
        struct TodaySectionViewModel: SectionWithItemsViewModel {
            init(itemViewModels: [TodayCellViewModel] = []) {
                self.itemViewModels = itemViewModels
            }
            
            
            let itemViewModels: [TodayCellViewModel]
        }
        //MARK: TodayCellViewModel
        struct TodayCellViewModel {
            init(overview: String = .emptyString) {
                self.overview = overview
            }
            let overview: String
            
        }
        
    }
    
}
