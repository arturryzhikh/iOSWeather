//
//  TodayCellViewModel.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import Foundation

struct TodayCellViewModel {
    init(overview: String = .emptyString) {
        self.overview = overview
    }
    
    let overview: String
    
}
