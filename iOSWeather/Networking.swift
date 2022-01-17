//
//  Networking.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 14.01.2022.
//

import Foundation

public enum ResponseError: Error, CustomStringConvertible {
    case network
    case decoding
    case invalidEndPoint
    case invalidResponse
    public var description: String {
        switch self {
        case .network:
            return "failed network fetching"
        case .decoding:
            return "failed decoding data"
        case .invalidEndPoint:
            return "bad url"
        case .invalidResponse:
            return "Could not decode into valid response"
        }
    }

}

public protocol Networking {
    func request<Request: NetworkRequest>(_ request: Request, completion: @escaping (Result<Request.NetworkResponse, Error>) -> Void)
    
}

