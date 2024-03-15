//
//  PrductViewModel.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 05/03/24.
//

import Foundation

final class ProductViewModel {
    
    var productListService: ProductListServiceProtocol
    
    init(productListService: ProductListServiceProtocol = ProductListService() ) {
        self.productListService = productListService
    }
    
    var product: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchProduct() {
        self.eventHandler?(.loading)
        productListService.getProductList { response in
            self.eventHandler?(.stoploading)
            switch response {
            case .success(let product):
                self.product = product
                self.eventHandler?(.loaded)
                //print(product)
            case .failure(let error):
                self.eventHandler?(.loadingError(error))
                //print(error)
            }
        }
//        productListService.fetchData(requestURL: URL(string: Constant.API.productURL),
//                                    resultType: [Product].self,
//                                    completion: { response in
//            self.eventHandler?(.stoploading)
//            switch response {
//            case .success(let product):
//                self.product = product
//                self.eventHandler?(.loaded)
//                //print(product)
//            case .failure(let error):
//                self.eventHandler?(.loadingError(error))
//                //print(error)
//            }
//        })
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
