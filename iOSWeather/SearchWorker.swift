//
//  SearchWorker.swift
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

class SearchWorker {
    init(apiService: Networking = ApiService()) {
        self.apiService = apiService
    }
    
    private let apiService: Networking
    
    func getCities(request: Search.Requests.CitiesRequest, completion: @escaping (Result<[Search.Responses.Place],Error>) -> Void) {
        
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
