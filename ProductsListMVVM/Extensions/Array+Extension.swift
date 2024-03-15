//
//  Array+Extension.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 15/03/24.
//

extension Array {
    func has(index: Int) -> Bool {
        return (0..<count).contains(index)
    }
}
