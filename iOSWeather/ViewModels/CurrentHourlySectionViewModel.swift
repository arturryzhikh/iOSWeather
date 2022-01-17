//
//  CurrentHourlySectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

struct CurrentHourlySectionViewModel: SectionWithHeaderViewModel, SectionWithFooterViewModel {
    init(headerViewModel: CurrentHeaderViewModel = .init(),
         footerViewModel: HourlyFooterViewModel = .init()) {
        self.headerViewModel = headerViewModel
        self.footerViewModel = footerViewModel
    }
    
    var count: Int {
        return 0
    }
    let headerViewModel: CurrentHeaderViewModel
    let footerViewModel : HourlyFooterViewModel
}

