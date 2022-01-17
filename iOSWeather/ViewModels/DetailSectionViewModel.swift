//
//  DetailSectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import Foundation



struct DetailSectionViewModel: SectionWithItemsViewModel {
    init(itemViewModels: [DetailCellViewModel] = []) {
        self.itemViewModels = itemViewModels
    }
    let itemViewModels: [DetailCellViewModel]
  
}
