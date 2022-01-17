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
            var queries: [String : String] = [
                "exclude" :  "alerts"
            ]
            
            init (coordinate: (lat: Double, lon: Double),
                  language: String = "en",
                  units: String = "metric",
                  apiKey: String = API.key) {
                queries.updateValue(String(coordinate.lat), forKey: "lat")
                queries.updateValue(String(coordinate.lon), forKey: "lon")
                queries.updateValue(language, forKey: "lang")
                queries.updateValue(units, forKey: "units")
                queries.updateValue(apiKey, forKey: "appid")
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
                case currentHourly,
                     daily,
                     today,
                     detail,
                     link
            }
            
            init(currentHourlySectionVM: CurrentHourlySectionViewModel = CurrentHourlySectionViewModel.init(),
                dailySectionVM: DailySectionViewModel = DailySectionViewModel(),
                todaySectionVM: TodaySectionViewModel = .init(),
                detailSectionVM: DetailSectionViewModel = .init(),
                linkSectionVM: LinkSectionViewModel = .init()) {
                    self.currentHourlySectionVM = currentHourlySectionVM
                    self.dailySectionVM = dailySectionVM
                    self.todaySectionVM = todaySectionVM
                    self.detailSectionVM = detailSectionVM
                    self.linkSectionVM = linkSectionVM
            }
            
            //MARK: Section View Models
            var currentHourlySectionVM: CurrentHourlySectionViewModel
            var dailySectionVM: DailySectionViewModel
            var todaySectionVM: TodaySectionViewModel
            var detailSectionVM: DetailSectionViewModel
            var linkSectionVM: LinkSectionViewModel
            
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
                    return currentHourlySectionVM.count
                    
                case .daily:
                    return dailySectionVM.count
                    
                case .today:
                    return todaySectionVM.count
                    
                case .detail:
                    return detailSectionVM.count
                case .link:
                    return linkSectionVM.count
                    
                default:
                    return 0
                }
            }
  
        }
    }
}
