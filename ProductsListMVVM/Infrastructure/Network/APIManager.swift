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
    
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(resultType: T.Type,
                                 router: APIRouter,
                                 completion: @escaping (Result<T, NetworkError>) -> Void) {
        aPIHandler.fetchData(router: router) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: resultType, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

protocol APIHandlerDelegate {
    func fetchData(router: APIRouter, completion: @escaping(Result<Data, NetworkError>) -> Void)
}

class APIHandler: APIHandlerDelegate {
    func fetchData(router: APIRouter, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: router.asURLRequest()) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.invalidData))
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                return completion(.failure(.invalidResponse))
            }
            completion(.success(data))
           
        }.resume()
    }
    
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, NetworkError>) -> Void)
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, NetworkError>) -> Void) {
        let commentResponse = try? JSONDecoder().decode(type.self, from: data)
        if let commentResponse = commentResponse {
            return completion(.success(commentResponse))
        } else {
            completion(.failure(.decodingError))
        }
    }
    
}
