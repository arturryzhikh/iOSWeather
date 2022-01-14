//
//  NetworkDataRequest.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 14.01.2022.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol NetworkRequest {
    associatedtype NetworkResponse
    var url: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [String: String] { get }
    func decode(_ data: Data) throws -> NetworkResponse
}

extension NetworkRequest {
    var headers: [String: String] { return [:] }
    var queryItems: [String: String] { [:] }
}

extension NetworkRequest where NetworkResponse: Decodable {
    func decode(_ data: Data) throws -> NetworkResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(NetworkResponse.self, from: data)
    }
}
