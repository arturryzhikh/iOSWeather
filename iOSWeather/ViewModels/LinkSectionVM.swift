//
//  LinkSectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation



struct LinkSectionVM: ItemRepresentable, ModelInstantiable {
    
    var numberOfItems: Int {
        return items.count
    }
    var model: WeatherResponse
    
    init(model: WeatherResponse) {
        self.model = model
    }
    var items: [LinkCellVM] {
        var items: [LinkCellVM] = []
        items.append(LinkCellVM(model: model))
        return items
    }
    
}

struct LinkCellVM: ModelInstantiable {
    
    let model: WeatherResponse
    
    var link: NSMutableAttributedString {
        guard let timezone = model.timezone else {
            return NSMutableAttributedString(string: "")
        }
        let location = timezone.components(separatedBy: "/")[1]
            .replacingOccurrences(of: "_", with: " ")
        let attrSting = NSMutableAttributedString(string: "Weather for \(location). Thanks to Open Weather Map!")
        return attrSting
    }
    
    
    init(model: WeatherResponse) {
        self.model = model
        
    }
    
}

