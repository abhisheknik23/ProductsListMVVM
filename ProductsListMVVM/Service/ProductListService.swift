//
//  ProductListService.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 06/03/24.
//

import Foundation

protocol ProductListServiceProtocol {
    func getProductList(completion: @escaping(Result<[Product], NetworkError>) -> Void)
}

class ProductListService: ProductListServiceProtocol, APIManager {
    func getProductList(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        request(resultType: [Product].self,
                       router: APIRouter.getProductList,
                       completion: completion)
    }
    
    
}
