//
//  DailySectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

struct DailySectionViewModel: SectionWithItemsViewModel {
    init(itemViewModels: [DailyCellViewModel] = []) {
        self.itemViewModels = itemViewModels
    }
    
    let itemViewModels: [DailyCellViewModel]

}
