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

extension HttpResponse {

    /// Converts the response data to a UTF-8 String value
    public var utf8String: String? {
        String(data: data, encoding: .utf8)
    }

    public var traceLogValue: String {
        let prettyHeaders =
            headers
            .map { "\($0.key.rawValue): \($0.value)" }
            .sorted()
            .joined(separator: "\n")

        return """

            \(prettyHeaders)
            \(statusCode.rawValue)
            """
    }
}
