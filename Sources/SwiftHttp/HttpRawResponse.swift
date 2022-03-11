//
//  HttpRawResponse.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

/// A HTTP response object with a raw data value
public struct HttpRawResponse: HttpResponse {

    /// The status code of the response
    public let statusCode: HttpStatusCode
    
    /// The header fields for the response
    public let headers: [HttpHeaderKey: String]
    
    /// The raw data value for the response
    public let data: Data

    ///
    /// Initialize the response
    ///
    /// - Parameter statusCode: The status code
    /// - Parameter headers: The header fields
    /// - Parameter data: The body data
    ///
    public init(statusCode: HttpStatusCode, headers: [HttpHeaderKey: String], data: Data) {
        self.statusCode = statusCode
        self.headers = headers
        self.data = data
    }

    ///
    /// Initialize the response
    ///
    /// - Parameter tuple: A tuple value with a Data, URLResponse type
    ///
    /// - Throws: `HttpError` if something was wrong with the tuple values
    ///
    public init(_ tuple: (Data, URLResponse)) throws {
        guard let response = tuple.1 as? HTTPURLResponse else {
            throw HttpError.invalidResponse
        }
        var headers: [HttpHeaderKey: String] = [:]
        for header in response.allHeaderFields {
            let key = String(describing: header.key)
            let value = String(describing: header.value)
            var headerKey: HttpHeaderKey = .custom(key)
            if let keyValue = HttpHeader(rawValue: key) {
                headerKey = .key(keyValue)
            }
            headers[headerKey] = value
        }
        guard let statusCode = HttpStatusCode(rawValue: response.statusCode) else {
            throw HttpError.unknownStatusCode
        }
        self.init(statusCode: statusCode, headers: headers, data: tuple.0)
    }
}

