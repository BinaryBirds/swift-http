//
//  HttpDataEncoder.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// Encodes an encodable object into a HTTP data representation
public protocol HttpDataEncoder {
    
    ///
    /// Encodes the object value into raw HTTP data
    ///
    /// - Parameter value: The encodable object instance
    ///
    /// - Throws: `Error` if something was wrong with the encoding
    ///
    /// - Returns: The encoded data value
    ///
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

/// The JSON encoder is already a valid HTTP data encoder
extension JSONEncoder: HttpDataEncoder {}

/// The property list encoder is already a valid HTTP data encoder
extension PropertyListEncoder: HttpDataEncoder {}
