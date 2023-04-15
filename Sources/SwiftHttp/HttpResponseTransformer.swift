//
//  HttpResponseTransformer.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// Transforms a given response into a decodable object and validates it upfront
public protocol HttpResponseTransformer {

    /// The decodable object type
    associatedtype T: Decodable

    /// Validators to perform before the decoding
    var validators: [HttpResponseValidator] { get }

    ///
    /// Decodes the response data into a custom decodable object
    ///
    /// - Parameter data: The HttpResponse data
    ///
    /// - Throws: `Error` if something was wrong with the decoding
    ///
    /// - Returns: The decoded object
    ///
    func decode(_ data: Data) throws -> T
}
