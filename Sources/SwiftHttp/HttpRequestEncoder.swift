//
//  HttpRequestEncoder.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

/// A request encoder that can transform an encodable object into a request body and add headers to the request
public struct HttpRequestEncoder<T: Encodable>: HttpRequestTransformer {

    /// The response valdators
    public let headers: [HttpHeaderKey: String]
    
    let encoder: HttpDataEncoder

    ///
    /// Initialize a request encoder
    ///
    /// - Parameter encoder: The encoder used to encode the data
    /// - Parameter validators: The additional header fields
    ///
    public init(encoder: HttpDataEncoder, headers: [HttpHeaderKey: String] = [:]) {
        self.encoder = encoder
        self.headers = headers
    }

    ///
    /// Encodes the content value using the decoder
    ///
    /// - Parameter content: The encodable content
    ///
    /// - Throws: `Error` if something was wrong during the encoding
    ///
    /// - Returns: The encoded data value
    ///
    public func encode(_ content: T) throws -> Data {
        try encoder.encode(content)
    }
}

public extension HttpRequestEncoder {

    ///
    /// Initialize a JSON request encoder
    ///
    /// - Parameter encoder: The JSONEncoder object to use, the default is the built in JSONEncoder
    /// - Parameter headers: The default accept and content type headers for a JSON request
    ///
    static func json(_ encoder: JSONEncoder = .init(),
                     headers: [HttpHeaderKey: String] = [
                         .accept: "application/json",
												 .contentType: "application/json",
                     ]) -> HttpRequestEncoder {
        .init(encoder: encoder, headers: headers)
    }
}
