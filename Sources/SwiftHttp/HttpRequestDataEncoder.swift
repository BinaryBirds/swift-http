//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpRequestDataEncoder<T: Encodable>: HttpRequestDataTransformer {

    public let headers: [HttpHeaderKey: String]
    let encoder: HttpDataEncoder

    public init(encoder: HttpDataEncoder, headers: [HttpHeaderKey: String] = [:]) {
        self.encoder = encoder
        self.headers = headers
    }

    public func encode(_ content: T) throws -> Data {
        try encoder.encode(content)
    }
}

public extension HttpRequestDataEncoder {

    static func json(_ encoder: JSONEncoder = .init(),
                     headers: [HttpHeaderKey: String] = [
                         .key(.accept): "application/json",
                         .key(.contentType): "application/json",
                     ]) -> HttpRequestDataEncoder {
        .init(encoder: encoder, headers: headers)
    }
}
