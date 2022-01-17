//
//  DetailCellViewModel.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import Foundation

struct DetailCellViewModel {
    init(title: String = .emptyString,
         value: String = .emptyString) {
        self.title = title
        self.value = value
    }
    let title: String
    let value: String
}
 

