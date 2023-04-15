//
//  HttpRequest.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// A HttpRequest representation
public protocol HttpRequest {

    /// HTTP method of the request
    var method: HttpMethod { get }

    /// URL of the request
    var url: HttpUrl { get }

    /// Header fields for the request
    var headers: [HttpHeaderKey: String] { get }

    /// HTTP body as a data representation
    var body: Data? { get }
}

extension HttpRequest {

    /// Converts a HttpRequest to a URLRequest
    public var urlRequest: URLRequest {
        var request = URLRequest(url: url.url)
        request.httpMethod = method.rawValue.uppercased()
        request.httpBody = body
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key.rawValue)
        }
        return request
    }
}
