//
//  HttpRawResponse.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpRawResponse: HttpResponse {

    public let statusCode: HttpStatusCode
    public let headers: [HttpHeaderKey: String]
    public let data: Data

    public init(statusCode: HttpStatusCode, headers: [HttpHeaderKey: String], data: Data) {
        self.statusCode = statusCode
        self.headers = headers
        self.data = data
    }

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

