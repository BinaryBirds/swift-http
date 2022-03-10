//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpJsonRequestDataEncoder<T: Encodable>: HttpRequestDataEncoder {

    let encoder: JSONEncoder

    public init(encoder: JSONEncoder = .init()) {
        self.encoder = encoder
    }

    public func encode(_ content: T) throws -> Data {
        try encoder.encode(content)
    }
}
