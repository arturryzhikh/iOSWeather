//
//  Coordinates.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 18.01.2022.
//

import Foundation

class Coordinates: NSObject {
    let latitude: String
    let longitude: String
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
        
    }
}
