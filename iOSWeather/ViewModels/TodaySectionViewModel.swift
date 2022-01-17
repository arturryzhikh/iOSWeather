//
//  TodaySectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation



struct TodaySectionViewModel: SectionWithItemsViewModel {
    init(itemViewModels: [TodayCellViewModel] = []) {
        self.itemViewModels = itemViewModels
    }
    
    
    let itemViewModels: [TodayCellViewModel]
}
