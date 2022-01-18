//
//  SearchRouter.swift
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

@objc protocol SearchRoutingLogic {
    func showAlert(message: String)
    func routeToHome(with coordinates: Coord)
    func navigateToHome(source: SearchViewController?,
                        destination: HomeViewController?)
    
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get set }
    func passCoordinatesToHome(source: SearchDataStore? ,
                               destination: inout HomeDataStore?)
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
    
    weak var viewController: SearchViewController?
    
    var dataStore: SearchDataStore?
    //MARK: Alert
    func showAlert(message: String) {
        viewController?.presentAlert(message: message)
    }
    //MARK: Route
    func routeToHome(with coordinates: Coord) {
        self.dataStore?.coordinates = coordinates
        let destinationVC = HomeViewController()
        var destionationDS = destinationVC.router?.dataStore
        passCoordinatesToHome(source: dataStore , destination: &destionationDS)
        navigateToHome(source: viewController, destination: destinationVC)
    }
    
    
    //MARK: Navigation
    func navigateToHome(source: SearchViewController?, destination: HomeViewController?) {
        source?.navigationController?.dismiss(animated: true)
    }
    //MARK: Passing data
    func passCoordinatesToHome(source: SearchDataStore? , destination: inout HomeDataStore?) {
        destination?.coord = source?.coordinates
    }
}
