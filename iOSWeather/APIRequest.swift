//
//  APIRequest.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

protocol APIRequest: Encodable {
    
    associatedtype Response: Decodable
    
    var endPoint: String { get }
    
    var queries: [String:String] { get set }
    
}
