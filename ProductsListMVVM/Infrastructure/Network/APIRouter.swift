//
//  APIRouter.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 06/03/24.
//

import Foundation

/// Get / POST / PUT / PATCH/ DELETE
public enum AGHTTPMethod : String {
    case GET     = "GET"
    case POST    = "POST"
    case PUT     = "PUT"
    case PATCH   = "PATCH"
    case DELETE  = "DELETE"
}

public enum APIRouter {
    case getProductList
    
    var baseURL: URL {
        return URL(string: "https://fakestoreapi.com/")!
    }
    
    private var path: String {
        switch self {
        case .getProductList:
            return "products"
        }
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    private var method: AGHTTPMethod {
        switch self {
        case .getProductList:
            return AGHTTPMethod.GET
        }
    }
    
    public func asURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlrequest = URLRequest(url: url)
        urlrequest.httpMethod = method.rawValue
        return urlrequest

    }
}
/*
 
 import Foundation

 // Define a simple router to handle API endpoints
 enum APIRouter {
     case fetchData
     case postData(parameters: [String: Any])

     var baseURL: URL {
         return URL(string: "https://api.example.com")!
     }

     var path: String {
         switch self {
         case .fetchData:
             return "/data"
         case .postData:
             return "/post"
         }
     }

     var method: String {
         switch self {
         case .fetchData:
             return "GET"
         case .postData:
             return "POST"
         }
     }

     var headers: [String: String] {
         return ["Content-Type": "application/json"]
     }

     var body: Data? {
         switch self {
         case .fetchData:
             return nil
         case .postData(let parameters):
             return try? JSONSerialization.data(withJSONObject: parameters)
         }
     }

     func asURLRequest() -> URLRequest {
         let url = baseURL.appendingPathComponent(path)
         var request = URLRequest(url: url)
         request.httpMethod = method
         request.allHTTPHeaderFields = headers
         request.httpBody = body
         return request
     }
 }
 */
