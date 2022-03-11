//
//  HttpDataDecoder.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// A generic HTTP data decoder
public protocol HttpDataDecoder {
    
    ///
    /// Decodes the response data into a custom decodable object
    ///
    /// - Parameter type: The type of the decodable object
    /// - Parameter data: The HttpResponse data
    ///
    /// - Throws: `Error` if something was wrong with the decoding
    ///
    /// - Returns: The decoded object
    ///
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

/// The JSON decoder is already a valid HTTP data decoder
extension JSONDecoder: HttpDataDecoder {}

/// The property list decoder is already a valid HTTP data decoder
extension PropertyListDecoder: HttpDataDecoder {}
