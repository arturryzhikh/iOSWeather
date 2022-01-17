//
//  ViewModelRepresentable.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit
protocol ViewRepresentable {
    
    associatedtype T
    var viewModel: T? { get }
    func populateSubviews(with viewModel: T)
    
}

