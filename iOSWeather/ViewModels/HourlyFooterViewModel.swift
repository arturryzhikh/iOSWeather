//
//  horly.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 16.01.2022.
//

import Foundation

struct HourlyFooterViewModel: SectionWithItemsViewModel {
    
    init(itemViewModels: [HourlyItemViewModel] = []) {
        self.itemViewModels = itemViewModels
    }
    
    let itemViewModels: [HourlyItemViewModel]

}
