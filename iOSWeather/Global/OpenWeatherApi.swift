//
//  API.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation
enum Api {
    fileprivate static let scheme = "https://"
    enum OpenWeatherMap {
        static let oneCallendpoint = Api.scheme + "api.openweathermap.org/data/2.5/onecall"
        static let key = "4672f6951ef8d24128c8086d39c9a263"
        static let weatherForCity = Api.scheme + "api.openweathermap.org/data/2.5/weather"
        
    }
    enum Nominatim {
        static let search =  Api.scheme + "nominatim.openstreetmap.org/search"
        
        
//        """
//        The search term may be specified with two different sets of parameters:
//        
//        q=<query>
//
//        Free-form query string to search for. Free-form queries are processed first left-to-right and then right-to-left if that fails. So you may search for pilkington avenue, birmingham as well as for birmingham, pilkington avenue. Commas are optional, but improve performance by reducing the complexity of the search.
//        street=<housenumber> <streetname>
//        city=<city>
//        county=<county>
//        state=<state>
//        country=<country>
//        postalcode=<postalcode>
//
//        Alternative query string format split into several parameters for structured requests. Structured requests are faster but are less robust against alternative OSM tagging schemas. Do not combine with q=<query> parameter.
//        Both query forms accept the additional parameters listed below.
//        street=<housenumber> <streetname>
//        city=<city>
//        county=<county>
//        state=<state>
//        country=<country>
//        postalcode=<postalcode>
//        
//        """
    }
}
