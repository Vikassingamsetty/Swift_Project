//
//  RestService.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 01/04/22.
//

import Foundation

enum Method: String {
    case get = "GET"
}

final class APIService {
    
    static let shared = APIService()
    private init(){}
    
    public func getAppleArticles(with url: URL?, completion: @escaping(Result<[Article], Error>) -> Void) {
        
        guard let articleURL = url else {return}
        
        var urlRequest = URLRequest(url: articleURL)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = Method.get.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do{
                    let result = try JSONDecoder().decode(ArticleResponse.self, from: data)
                    completion(.success(result.articles))
                }catch{
                    completion(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    
}


