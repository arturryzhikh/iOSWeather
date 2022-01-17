//
//  SearchInteractor.swift
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

protocol SearchBusinessLogic {
    func searchCities(request: Search.Requests.CitiesRequest)
}

protocol SearchDataStore {
    //var name: String { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?
    //var name: String = ""
    
    // MARK: Search Cities
    
    func searchCities(request: Search.Requests.CitiesRequest) {
        worker = SearchWorker()
        worker?.getCities(request: request) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case.failure(let error):
                self.presenter?.presentError(message: "Error getting city \(error)")
            case.success(let response):
                self.presenter?.presentCities(response: response)
            }
        }

    }
}
