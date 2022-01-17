//
//  HomeWorker.swift
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

class HomeWorker {
    
    private var apiService: Networking!
    init(apiService: Networking = ApiService()) {
        self.apiService = apiService
    }
    
    func getForecast(request: Home.Requests.Request, completion: @escaping (Result<Home.Responses.Response,Error>) -> Void) {
        apiService.request(request) { result in
            switch result {
            case.failure(let error):
                completion(.failure(error))
            case.success(let response):
                completion(.success(response))
            }
        }
    }
}

