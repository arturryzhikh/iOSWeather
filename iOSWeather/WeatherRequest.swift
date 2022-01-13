//
//  WeatherRequest.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import Foundation


struct WeatherRequest: APIRequest {
    
    typealias Response = WeatherResponse
    
    var endPoint: String {
        return API.oneCallendpoint
    }
//    String(Locale.current.languageCode ?? "en") //current language code
    var queries: [String : String ] = [
        "lang" : "ru" ,
        "exclude" :  "alerts",
        "units": "metric",
    ]
    
    init(latitude: Double, longitude: Double) {
        queries.updateValue(String(latitude), forKey: "lat")
        queries.updateValue(String(longitude), forKey: "lon")
        
    }
}
