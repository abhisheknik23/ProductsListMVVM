//
//  ProductCellViewModel.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 15/03/24.
//

import Foundation

class ProductCellViewModel {
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var productTitle: String? {
        return product.title
    }
    
    var category: String? {
        return product.category
    }
    
    var description: String? {
        return product.description
    }
    
    var price: Float {
        return product.price ?? 0
    }
    
    var rating: Float? {
        return product.rating?.rate ?? 0
    }
    
    var image: String {
        return product.image ?? ""
    }
    
}
