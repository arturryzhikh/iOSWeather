//
//  SearchViewModelBuilder.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import Foundation

class SearchViewModelBuilder: ViewModelBuilding {
    init(model: Search.Responses.ForecastResponse) {
        self.model = model
    }
    
    private let model: Search.Responses.ForecastResponse
    
    func buildViewModel() -> Search.ViewModels.ViewModel {
        let name = model.name
        let temp = temperatureString(temperature: model.main.temp)
        return Search.ViewModels.ViewModel(coord: model.coord, name: name, temperature: temp)
    }
    
}
