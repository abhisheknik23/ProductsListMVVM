//
//  Configurable.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 15/03/24.
//

import Foundation

protocol Configurable {
    associatedtype ModelType
    func configure(with model: ModelType)
}
