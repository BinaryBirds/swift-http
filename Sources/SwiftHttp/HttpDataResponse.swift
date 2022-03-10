//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpDataResponse: HttpResponse {

    public let statusCode: HttpStatusCode
    public let headers: [String: String]
    public let data: Data

    public init(statusCode: HttpStatusCode, headers: [String: String], data: Data) {
        self.statusCode = statusCode
        self.headers = headers
        self.data = data
    }

    public init(_ tuple: (Data, URLResponse)) throws {
        guard let response = tuple.1 as? HTTPURLResponse else {
            throw HttpError.invalidResponse
        }
        var headers: [String: String] = [:]
        for header in response.allHeaderFields {
            headers[String(describing: header.key)] = String(describing: header.value)
        }
        guard let statusCode = HttpStatusCode(rawValue: response.statusCode) else {
            throw HttpError.invalidStatusCode
        }
        self.init(statusCode: statusCode, headers: headers, data: tuple.0)
    }
}

