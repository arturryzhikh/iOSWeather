//
//  HomeInteractor.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 14.01.2022.
//  Copyright (c) 2022 Artur Ryzhikh. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeBusinessLogic {
    func getForecast(_ request: Home.Requests.Request)
}

protocol HomeDataStore {
    var coordinates: Coordinates? { get set }
}

class HomeInteractor: NSObject, HomeBusinessLogic, HomeDataStore {
    
    var coordinates: Coordinates?
    var errorMessage: String = .emptyString
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    // MARK: Get Forecast
    func getForecast(_ request: Home.Requests.Request) {
        worker = HomeWorker()
        worker?.getForecast(request: request) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case.failure(let error):
                print(error)
                self.errorMessage = "Error occured while fetching weather"
                self.presenter?.presentError(message: self.errorMessage)
            case.success(let response):
                self.presenter?.presentWeather(response: response)
            }
        }
    }
    
}

