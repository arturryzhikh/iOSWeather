//
//  LinkSectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation



struct LinkSectionViewModel: SectionWithItemsViewModel  {
    init(itemViewModels: [LinkCellViewModel] = []) {
        self.itemViewModels = itemViewModels
    }
    let itemViewModels: [LinkCellViewModel]
 
}
