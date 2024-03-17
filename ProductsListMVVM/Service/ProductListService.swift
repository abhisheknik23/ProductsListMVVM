//
//  ProductListService.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 06/03/24.
//

import Foundation

protocol ProductServiceDelegate: ProductListServiceDelegate, UserListServiceDelegate {
    
}

protocol ProductListServiceDelegate {
    func getProductList(completion: @escaping(Result<[Product], NetworkError>) -> Void)
   
}

protocol UserListServiceDelegate {
    func getUserList(completion: @escaping(Result<[Product], NetworkError>) -> Void)
}

class ProductListService: ProductServiceDelegate {
    func getProductList(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        APIManager().fetchRequest(resultType: [Product].self, router: APIRouter.getProductList, completion: completion)
    }
    
    func getUserList(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        APIManager().fetchRequest(resultType: [Product].self, router: APIRouter.getProductList, completion: completion)
    }
    
}
