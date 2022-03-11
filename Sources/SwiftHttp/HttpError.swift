//
//  HttpError.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Foundation

/// A generic error object to transfer HTTP related error messages
public enum HttpError: LocalizedError {
    
    /// The response is not a valid HTTP response
    case invalidResponse
    
    /// The response has a unknown status code
    case unknownStatusCode
    
    /// The response has an invalid status code
    case invalidStatusCode(HttpResponse)
    
    /// The response is missing a header
    case missingHeader(HttpResponse)
    
    /// The response has an invalid header value
    case invalidHeaderValue(HttpResponse)
    
    /// Unknown error
    case unknown(Error)
    
    /// Proper error descriptions  for the HttpError values
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .unknownStatusCode:
            return "Unknown status code"
        case .invalidStatusCode(let response):
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
