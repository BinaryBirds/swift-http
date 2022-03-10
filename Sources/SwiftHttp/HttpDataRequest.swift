//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpDataRequest: HttpRequest {

    public var method: HttpMethod
    public var url: HttpUrl
    public var headers: [String: String]
    public var body: Data?

    public init(url: HttpUrl,
                method: HttpMethod = .get,
                headers: [String: String] = [:],
                body: Data? = nil) {
        self.method = method
        self.url = url
        self.headers = headers
        self.body = body
    }
}

public extension HttpDataRequest {

    func method(_ method: HttpMethod) -> HttpDataRequest {
        .init(url: url, method: method, headers: headers, body: body)
    }

    func header(_ key: HttpHeader, _ value: String) -> HttpDataRequest {
        header(key.rawValue, value)
    }

    func header(_ key: String, _ value: String) -> HttpDataRequest {
        var newHeaders = headers
        newHeaders[key] = value
        return .init(url: url, method: method, headers: newHeaders, body: body)
    }
    
    func body(_ body: Data) -> HttpDataRequest {
        .init(url: url, method: method, headers: headers, body: body)
    }
}
