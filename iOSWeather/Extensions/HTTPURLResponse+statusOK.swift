//
//  HTTPURLResponse+statusOK.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

extension HTTPURLResponse {
    
    var statusOK: Bool {
        return (200...299).contains(statusCode)
    }
    
}

