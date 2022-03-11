//
//  HttpResponseValidation.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// Validates a HttpResponse using an array of validators
public struct HttpResponseValidation {
    
    let validators: [HttpResponseValidator]
    
    ///
    /// Initialize a new validation object using an array of validators
    ///
    /// - Parameter validators: The array of HttpResponseValidators
    ///
    public init(_ validators: [HttpResponseValidator]) {
        self.validators = validators
    }

    ///
    /// Validates a HTTP response object using all of the validators
    ///
    /// - Parameter response: The HttpResponse object
    ///
    /// - Throws: `Error` if something was wrong with the validation
    ///
    public func validate(_ response: HttpResponse) throws {
        for validator in validators {
            try validator.validate(response)
        }
    }
}
