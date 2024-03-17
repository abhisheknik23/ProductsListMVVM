//
//  MockAPIManager.swift
//  ProductsListMVVMTests
//
//  Created by Abhishek Gupta on 06/03/24.
//

import Foundation
@testable import ProductsListMVVM

class MockProductService: ProductServiceDelegate {
    
    var shoudThrowError: NetworkError?
    
    func getProductList(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        if let showError = shoudThrowError {
            switch showError {
            case .decodingError:
                completion(.failure(.decodingError))
            case .invalidData:
                completion(.failure(.invalidData))
            case .invalidUrl:
                completion(.failure(.invalidUrl))
            case .invalidResponse:
                completion(.failure(.invalidResponse))
            default:
                completion(.failure(.network(nil)))
            }
            return
        }
        guard let products = readProductList() else {
            completion(.failure(.decodingError))
            return
        }
        completion(.success(products))
    }
    
    func getUserList(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        
        if let showError = shoudThrowError {
            switch showError {
            case .decodingError:
                completion(.failure(.decodingError))
            case .invalidData:
                completion(.failure(.invalidData))
            case .invalidUrl:
                completion(.failure(.invalidUrl))
            case .invalidResponse:
                completion(.failure(.invalidResponse))
            default:
                completion(.failure(.network(nil)))
            }
            return
        }
        guard let products = readProductList() else {
            completion(.failure(.decodingError))
            return
        }
        completion(.success(products))
    }
    
    private func readProductList() -> [Product]? {
        // Read local json file MockData
        do {
            guard let url = Bundle(for: MockProductService.self).url(forResource: "MockData", withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            return nil
        }
    }
}
