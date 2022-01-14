//
//  WeatherRequest.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import Foundation

struct WeatherRequest: APIRequest {
    
    typealias Response = Forecast
    
    var endPoint: String {
        return API.oneCallendpoint
    }
    var queries: [String : String ] = [
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
