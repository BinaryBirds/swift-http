//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Foundation

public enum HttpError: LocalizedError {
    case invalidResponse
    case invalidStatusCode
    case statusCode(HttpResponse)
    case missingHeader(HttpResponse)
    case invalidHeaderValue(HttpResponse)
    case unknown(Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .invalidStatusCode:
            return "Invalid status code"
        case .statusCode(let response):
            return "Invalid status code: \(response.statusCode.rawValue)"
        case .missingHeader(_):
            return "Missing header"
        case .invalidHeaderValue(_):
            return "Invalid header value"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
