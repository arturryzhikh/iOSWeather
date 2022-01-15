//
//  ViewModelBuilder.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 15.01.2022.
//

import Foundation
protocol ViewModelBuilding {
    
    associatedtype ViewModel
    associatedtype Model
    var model: Model { get }
    func buildViewModel() -> ViewModel
   
    
}

public final class ViewModelBuilder: ViewModelBuilding {
    
    let model: Home.Weather.Response
    
    init(model: Home.Weather.Response) {
        self.model = model
    }
    func buildViewModel() -> Home.Weather.ViewModel {
        return Home.Weather.ViewModel()
    }
    
    
}
