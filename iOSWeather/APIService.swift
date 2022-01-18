//
//  ApiService.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 14.01.2022.
//

import Foundation

extension HTTPURLResponse {
    
    var statusOK: Bool {
        return (200...299).contains(statusCode)
    }
    
}


public final class ApiService: Networking {
    
    public func request<Request: NetworkRequest>(_ request: Request, completion: @escaping (Result<Request.NetworkResponse, Error>) -> Void) {
        
        guard var urlComponent = URLComponents(string: request.url) else {
            let error = NSError(
                domain: ResponseError.invalidEndPoint.description,
                code: 404,
                userInfo: nil
            )
            
            return completion(.failure(error))
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.queries.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        
        guard let url = urlComponent.url else {
            let error = NSError(
                domain: ResponseError.invalidEndPoint.description,
                code: 404,
                userInfo: nil
            )
            
            return completion(.failure(error))
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse else  {
                
                let error = NSError(domain: ResponseError.badResponse.description,
                                    code: 400, userInfo: nil)
                completion(.failure(error))
                return
            }
            guard response.statusOK else {
                let error = NSError(domain: ResponseError.badResponse.description,
                               code: response.statusCode,
                               userInfo: nil)
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: ResponseError.nothingToDecode.description,
                                    code: response.statusCode,
                                    userInfo: nil)
                return completion(.failure(error))
                
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }
}

