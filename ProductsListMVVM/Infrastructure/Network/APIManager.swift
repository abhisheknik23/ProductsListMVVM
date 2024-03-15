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

protocol APIManager {
    
    func request<T: Decodable>(resultType: T.Type,
                                 router: APIRouter,
                                 completion: @escaping (Result<T, NetworkError>) -> Void)
}

extension APIManager {
    
    
    func request<T: Decodable>(resultType: T.Type,
                                 router: APIRouter,
                                 completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: router.asURLRequest()) { data, response, error in
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
    
//    func fetchProductList(completion: @escaping (Result<[Product], NetworkError>) -> Void)  {
//        return request(resultType: [Product].self,
//                       router: APIRouter.getProductList,
//                       completion: completion)
//    }
    
}
