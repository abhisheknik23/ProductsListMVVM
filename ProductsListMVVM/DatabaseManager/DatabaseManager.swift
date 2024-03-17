//
//  DatabaseManager.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 16/03/24.
//

import Foundation

class DatabaseManager: ProductListServiceDelegate {
    func getProductList(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        guard let url = Bundle.main.url(forResource: "Products", withExtension: "json"),
              let data = try? Data(Data(contentsOf: url)),
              let model = try? JSONDecoder().decode([Product].self, from: data) else {
            return completion(.failure(.decodingError))
        }
        completion(.success(model))
    }
    
}
