//
//  APIManager.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 05/03/24.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidData
    case invalidResponse
    case decodingError
    case network(Error?)
}

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(requestURL: URL?, resultType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let requestURL else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let pruduct = try JSONDecoder().decode(T.self, from: data)
                completion(.success(pruduct))
                
            } catch {
                completion(.failure(.network(error)))
            }
            
        }.resume()
    }
    
}
