//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Foundation

public protocol HttpRequest {
    var method: HttpMethod { get }
    var url: HttpUrl { get }
    var headers: [HttpHeaderKey: String] { get }
    var body: Data? { get }
}

public extension HttpRequest {
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url.url)
        request.httpMethod = method.rawValue.uppercased()
        request.httpBody = body
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key.keyValue)
        }
        return request
    }
}


