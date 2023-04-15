//
//  HttpHeaderValidator.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// Validates a header value using a key and a validation block
public struct HttpHeaderValidator: HttpResponseValidator {

    /// The header key to look for
    let key: HttpHeaderKey

    ///
    /// The validation block
    ///
    /// - Parameter The value of the header field
    ///
    /// - Returns: True if the value is valid, otherwise false
    ///
    let block: (String) -> Bool

    ///
    /// Initialize a new validator
    ///
    /// - Parameter key The header key to look up the value
    /// - Parameter blcok The validation block using the header value
    ///
    public init(
        _ key: HttpHeaderKey,
        _ block: @escaping ((String) -> Bool)
    ) {
        self.key = key
        self.block = block
    }

    ///
    /// Validate a response object.
    ///
    /// - Parameter response The response object that needs to be validated
    ///
    /// - Throws A HttpError object if the validation fails
    ///
    public func validate(_ response: HttpResponse) throws {
        guard let value = response.headers[key] else {
            throw HttpError.missingHeader(response)
        }
        guard block(value) else {
            throw HttpError.invalidHeaderValue(response)
        }
    }
}
