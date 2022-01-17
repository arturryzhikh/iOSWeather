//
//  Networking.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 14.01.2022.
//

import Foundation

public enum ResponseError: Error, CustomStringConvertible {
    case nothingToDecode
    case decoding
    case invalidEndPoint
    case invalidResponse
    case badResponse
    
    public var description: String {
        switch self {
        case .decoding:
            return "Failed decoding data"
        case .invalidEndPoint:
            return "Bad url"
        case .invalidResponse:
            return "Could not decode into valid response"
        case.nothingToDecode:
            return "Nothing to decode"
        case .badResponse :
            return "Bad Response"
        }
    
    }

}

public protocol Networking {
    func request<Request: NetworkRequest>(_ request: Request, completion: @escaping (Result<Request.NetworkResponse, Error>) -> Void)
    
}

