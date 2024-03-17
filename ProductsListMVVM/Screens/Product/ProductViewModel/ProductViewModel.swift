//
//  PrductViewModel.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 05/03/24.
//

import Foundation

final class ProductViewModel {
    
    var productListService: ProductServiceDelegate
    var databaseManager: ProductListServiceDelegate
    var product: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    init(productListService: ProductServiceDelegate = ProductListService(),
         databaseManager: ProductListServiceDelegate = DatabaseManager()) {
        self.productListService = productListService
        self.databaseManager = databaseManager
    }
    
    func fetchProduct() {
        if isIntetnetAvailable() {
            self.eventHandler?(.loading)
            productListService.getProductList { response in
                self.eventHandler?(.stoploading)
                switch response {
                case .success(let product):
                    self.product = product
                    self.eventHandler?(.loaded)
                case .failure(let error):
                    self.eventHandler?(.loadingError(error))
                }
            }
        } else {
            databaseManager.getProductList { response in
                self.eventHandler?(.stoploading)
                switch response {
                case .success(let product):
                    self.product = product
                    self.eventHandler?(.loaded)
                case .failure(let error):
                    self.eventHandler?(.loadingError(error))
                }
            }
        }
        
    }
    
    //Dummy function to implement SOLID's Open close principle
    func fetchUsers() {
        self.eventHandler?(.loading)
        productListService.getUserList { response in
            self.eventHandler?(.stoploading)
            switch response {
            case .success(let product):
                self.product = product
                self.eventHandler?(.loaded)
            case .failure(let error):
                self.eventHandler?(.loadingError(error))
            }
        }
    }
    
    private func isIntetnetAvailable() -> Bool {
        return true
    }
    
    func productCell(at index: IndexPath) -> ProductCellViewModel? {
        guard product.has(index: index.row) else { return nil }
        return ProductCellViewModel(product: product[index.row])
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stoploading
        case loaded
        case loadingError(Error?)
    }
}
