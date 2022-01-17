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

enum Home {
    // MARK: Use cases
    
    enum Weather
    {
        struct Request: NetworkRequest {
            var url: String {
                return API.oneCallendpoint
            }
            var httpMethod: HTTPMethod = .get
            typealias NetworkResponse = Home.Weather.Response
            var queryItems: [String : String] = [
                "exclude" :  "alerts"
            ]
            
            init (coordinate: (lat: Double, lon: Double),
                  language: String = "en",
                  units: String = "metric",
                  apiKey: String = API.key) {
                queryItems.updateValue(String(coordinate.lat), forKey: "lat")
                queryItems.updateValue(String(coordinate.lon), forKey: "lon")
                queryItems.updateValue(language, forKey: "lang")
                queryItems.updateValue(units, forKey: "units")
                queryItems.updateValue(apiKey, forKey: "appid")
            }
            
        }
        
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
        
        struct ViewModel {
            enum Section: Int, CaseIterable {
                case currentHourly, daily, today, detail, link
            }
            
            init() {
                
            }
            //MARK: Section View Models
            var currentHourlySectionVM: CurrentHourlySectionViewModel?
            var dailySectionVM: DailySectionVM?
            var todaySectionVM: TodaySectionVM?
            var detailSectionVM: DetailSectionVM?
            var linkSectionVM: LinkSectionVM?
            
            //MARK: Properties
            
            var sections: [Int] = [
                Section.currentHourly.rawValue,
                Section.daily.rawValue,
                Section.today.rawValue,
                Section.detail.rawValue,
                Section.link.rawValue
            ]
            
            var isFetching: Bool = false
            
            var numberOfSections: Int {
                return sections.count
            }
            func numberOfItemsIn(_ section: Int) -> Int {
                
                switch Section(rawValue: section) {
                    
                case .currentHourly:
                    return currentHourlySectionVM?.count ?? 0
                    
                case .daily:
                    return dailySectionVM?.numberOfItems ?? 0
                    
                case .today:
                    return todaySectionVM?.numberOfItems ?? 0
                    
                case .detail:
                    return detailSectionVM?.numberOfItems ?? 0
                case .link:
                    return linkSectionVM?.numberOfItems ?? 0
                    
                default:
                    return 0
                }
            }
            
            mutating func generateSectionViewModels(model: Home.Weather.Response) {
                currentHourlySectionVM = CurrentHourlySectionViewModel(
                    headerViewModel: CurrentHeaderViewModel(),
                    footerViewModel: HourlyFooterViewModel())
                dailySectionVM = DailySectionVM(model: model)
                todaySectionVM = TodaySectionVM(model: model)
                detailSectionVM = DetailSectionVM(model: model)
                linkSectionVM = LinkSectionVM(model: model)
                
            }
            
            
        }
    }
}
