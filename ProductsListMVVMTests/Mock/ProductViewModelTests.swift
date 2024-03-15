//
//  ProductViewModelTests.swift
//  ProductsListMVVMTests
//
//  Created by Abhishek Gupta on 06/03/24.
//

import XCTest
@testable import ProductsListMVVM

class ProductViewModelTests: XCTestCase {
    
    func test_ProductViewModel_Fetch_Products_Failure_Products_Array_ShouldEmpty() {
        let mockServiec = MockProductService()
        mockServiec.shoudThrowError = .decodingError
        let sut = ProductViewModel(productListService: mockServiec)
        sut.fetchProduct()
        XCTAssertTrue(sut.product.isEmpty)
    }
    
    func test_ProductViewModel_Fetch_Products_Success_Should_Initialize_Products_Array() {
        let mockServiec = MockProductService()
        let sut = ProductViewModel(productListService: mockServiec)
        sut.fetchProduct()
        XCTAssertTrue(!sut.product.isEmpty)
        XCTAssertEqual(sut.product.count, 20)
    }
    
    func test_productCell_Viewmodel() {
        let mockServiec = MockProductService()
        let sut = ProductViewModel(productListService: mockServiec)
        sut.fetchProduct()
        let cellViewModel = sut.productCell(at: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cellViewModel)
    }
    
    func test_productCell_Viewmodel_Nil() {
        let mockServiec = MockProductService()
        let sut = ProductViewModel(productListService: mockServiec)
        sut.fetchProduct()
        let cellViewModel = sut.productCell(at: IndexPath(row: 100, section: 0))
        XCTAssertNil(cellViewModel)
    }
}
