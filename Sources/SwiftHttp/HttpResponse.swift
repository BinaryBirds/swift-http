//
//  HttpResponse.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Foundation

/// A generic HttpResponse object
public protocol HttpResponse {
    
    /// The HTTP status code of the response
    var statusCode: HttpStatusCode { get }
    
    /// The HTTP response headers
    var headers: [HttpHeaderKey: String] { get }
    
    /// The HTTP response data
    var data: Data { get }
}


public extension HttpResponse {

    /// Converts the response data to a UTF-8 String value
    var utf8String: String? {
        String(data: data, encoding: .utf8)
    }
}
