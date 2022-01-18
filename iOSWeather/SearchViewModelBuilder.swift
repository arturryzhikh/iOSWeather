//
//  SearchViewModelBuilder.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import Foundation

class SearchViewModelBuilder: ViewModelBuilding {
    init(model: [Search.Responses.Place]) {
        self.model = model
    }
    
    private let model: [Search.Responses.Place]
    
    func buildViewModel() -> Search.ViewModels.ViewModel {
        let items = model.map {
            Search.ViewModels.PlaceViewModel(
                lat: $0.lat,
                lon: $0.lon,
                name: $0.displayName
            )
        }
        return Search.ViewModels.ViewModel(itemViewModels: items)
    }
    
}
