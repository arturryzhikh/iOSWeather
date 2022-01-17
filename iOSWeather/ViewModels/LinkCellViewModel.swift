//
//  LinkCellViewModel.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import Foundation

struct LinkCellViewModel {
    init(link: NSMutableAttributedString = .init()) {
        self.link = link
    }
    
    let link: NSMutableAttributedString
   
}

