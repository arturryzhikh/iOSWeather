//
//  WeatherRequest.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import Foundation
import CoreLocation


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
    init (location: CLLocation) {
        queries.updateValue(String(location.coordinate.latitude), forKey: "lat")
        queries.updateValue(String(location.coordinate.longitude), forKey: "lon")
    }
  
}
