//
//  HttpStatusCodeValidator.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

/// Validates a status code using an expected value
public struct HttpStatusCodeValidator: HttpResponseValidator {
    
    /// The expected status code
    let code: HttpStatusCode?
    
    ///
    /// Initialize a new validator
    ///
    /// If the expected status code value is `nil`, the default validation will occur.
    ///     By default a status code is valid if the value is between 200 and 299
    ///
    /// - Parameter code The expected status code value
    ///
    public init(_ code: HttpStatusCode? = nil) {
        self.code = code
    }

    ///
    /// Validate a response object.
    ///
    /// - Parameter response The response object that needs to be validated
    ///
    /// - Throws A HttpError object if the validation fails
    ///
    public func validate(_ response: HttpResponse) throws {
        if let code = code, response.statusCode != code {
            throw HttpError.invalidStatusCode(response)
        }
        guard response.statusCode.isValid else {
            throw HttpError.invalidStatusCode(response)
        }
    }
}

