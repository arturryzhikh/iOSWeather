//
//  ModelInstantiable.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import Foundation

protocol ModelInstantiable {
    
    associatedtype Model: Codable

    var model: Model { get }

    init(model: Model)
 
}

