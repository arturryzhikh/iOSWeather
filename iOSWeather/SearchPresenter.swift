//
//  SearchPresenter.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchPresentationLogic {
    func presentError(message: String)
    func presentCities(response: [Search.Responses.Place])
    
}

class SearchPresenter: SearchPresentationLogic {
  
    weak var viewController: SearchDisplayLogic?
    var builder: SearchViewModelBuilder? = nil
    
    // MARK: Do something
    func presentError(message: String) {
        
    }
    func presentCities(response: [Search.Responses.Place]) {
        builder = SearchViewModelBuilder(model: response)
        guard let builder = builder else {
            return
        }
        let viewModel = builder.buildViewModel()
        print(viewModel.itemViewModels.count)
        viewController?.displayCities(viewModel: viewModel)
    }
}
