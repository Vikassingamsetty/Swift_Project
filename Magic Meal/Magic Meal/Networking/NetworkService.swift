//
//  NetworkService.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import Foundation
import UIKit
import AVFoundation

struct NetworkService {
    
    static let shared = NetworkService()
    private init(){}
    
    //usage of networking calls
    func fetchAllCategories(completion: @escaping (Result<AllDishes, Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, parameters: nil, completion: completion)
    }
    
    func placeOrder(dishID: String, name: String, completion: @escaping (Result<Order, Error>) -> Void) {
         
        let params = ["name": name]
        request(route: .placeOrder(dishID), method: .post, parameters: params, completion: completion)
    }
    
    
    //Basic structure Networnking Calls
    func request<T: Decodable>(route: Route, method: Method, parameters: [String:Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
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
                self.handleResponse(result: result, completion: completion)
            }
            
        }.resume()
        
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
            
        case .success(let data):
            
            guard let response = try? JSONDecoder().decode(APIResponse<T>.self, from: data) else{
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
            }else{
                completion(.failure(AppError.unknownError))
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
        
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
