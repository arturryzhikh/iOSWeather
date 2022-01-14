//
//  WeatherService.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

final class WeatherService: APIService {
    
    private init() {
    }
    //Shared Session
    let session = URLSession.shared
    
    static let shared =  WeatherService()
    
    func request<T: APIRequest>(_ request: T, completion: @escaping ResultClosure<T.Response>)  {
        
        guard let url = makeURL(endPoint: request.endPoint, queries: request.queries)
        
        else {
            completion(Result.failure(.encoding))
            return
        }
        print(url)
        
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest , completionHandler: { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusOK , let data = data
            
            else {
                
                completion(Result.failure(ResponseError.network))
                
                return
            }
            
           guard let decoded = self.decode(data: data, into: T.Response.self) else {
                completion(Result.failure(ResponseError.decoding))
                return
            }
            
            completion(Result.success(decoded))
        
            
        }).resume()
    }
    
    func makeURL(endPoint: String, queries: [String : String]) -> URL? {
        var urlComponents = URLComponents(string: endPoint)
        urlComponents?.queryItems = queries.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return urlComponents?.url
    }
    
    //Decoding JSON
    func decode<T: Decodable>(data: Data, into model: T.Type)  ->  T?  {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try? decoder.decode(T.self, from: data)
        return result
        
    }
    
}
