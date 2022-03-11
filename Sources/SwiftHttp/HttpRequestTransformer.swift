//
//  HttpRequestTransformer.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// A request transformer that is capable of transforming the request data or add extra header values
public protocol HttpRequestTransformer {
    
    /// The encodable type that is going to be transformed into data
    associatedtype T: Encodable
    
    /// Additional header values for the request
    var headers: [HttpHeaderKey: String] { get }

    ///
    /// Encodes the generic content type to a data value
    ///
    /// - Parameter content: The encodable content instance
    ///
    /// - Throws: `Error` if something was wrong with the encoding
    ///
    /// - Returns: The encoded data value
    ///
    func encode(_ content: T) throws -> Data
}

