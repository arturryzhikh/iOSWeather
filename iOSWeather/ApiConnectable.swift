
//
//  ApiConnectable.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation


protocol ApiConnectable {
    
    
    var apiService: APIService! { get }
    
    var isFetching: Bool { get }
    
    
}
