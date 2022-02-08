//
//  NetworkService.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import Foundation
import UIKit

struct NetworkService {
    
    static let shared = NetworkService()
    private init(){}
    
    func request<T: Codable>(route: Route, method: Method, parameters: [String:Any]? = nil, type: T.Type, completion: (Result<T, Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: method, parameters: parameters) else{
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            
            if let data = data {
                result = .success(data)
                let resultData = String(data: data, encoding: .utf8) ?? "Unable to change data to string"
                print(resultData, "result")
            }
            if let error = error {
                result = .failure(error)
                print(error.localizedDescription, "found error")
            }
            
            DispatchQueue.main.async {
                // TODO Decode and send back results
            }
            
        }.resume()
        
    }
    
    //URL Request
    //CMD+Alt+/
    func createRequest(route: Route, method: Method, parameters: [String:Any]? = nil) -> URLRequest? {
        
        let urlString = Route.baseURL + route.description
        guard let url = urlString.asURL else {return nil}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponents = URLComponents(string: urlString)
                urlComponents?.queryItems = params.map{
                    URLQueryItem(name: $0, value: "\($1)")
                }
                urlRequest.url = urlComponents?.url
            case .post, .delete:
                let body = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = body
            }
        }
        
        return urlRequest
    }
    
}
