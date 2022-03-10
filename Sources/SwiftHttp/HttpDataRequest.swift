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
    public var headers: [HttpHeaderKey: String]
    public var body: Data?

    public init(url: HttpUrl,
                method: HttpMethod = .get,
                headers: [HttpHeaderKey: String] = [:],
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

    func header(_ key: HttpHeaderKey, _ value: String) -> HttpDataRequest {
        var newHeaders = headers
        newHeaders[key] = value
        return .init(url: url, method: method, headers: newHeaders, body: body)
    }
    
    func body(_ body: Data) -> HttpDataRequest {
        .init(url: url, method: method, headers: headers, body: body)
    }
}
