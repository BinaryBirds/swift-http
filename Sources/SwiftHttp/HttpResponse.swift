//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Foundation

public protocol HttpResponse {
    var statusCode: HttpStatusCode { get }
    var headers: [String: String] { get }
    var data: Data { get }
}


public extension HttpResponse {
    
    var utf8String: String? {
        String(data: data, encoding: .utf8)
    }
}
