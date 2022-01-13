//
//  APIService.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

protocol APIService {
    
    typealias ResultClosure<Value> = (Result<Value, ResponseError>) -> Void

    var session: URLSession { get }
    
    func request<T:APIRequest>(_ request: T, completion: @escaping ResultClosure<T.Response>)
    
    func decode<T:Codable>(data : Data, into model: T.Type) -> T?
    
    func makeURL(endPoint: String, queries: [String : String]) -> URL?
}


enum ResponseError: Error {
    
    case network
    case decoding
    case encoding
    
    var reason: String {
        switch self {
        case .network:
            return "Error occurred while fetching data"
        case .decoding:
            return "Error occurred while decoding data"
        case .encoding:
            return "Error encoding request into url"
        }
    }
}





