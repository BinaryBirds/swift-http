//
//  HttpResponseValidator.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

/// A generic response validator protocol
public protocol HttpResponseValidator {
    
    ///
    /// Validates a response object
    ///
    /// - Parameter response: The HTTP response
    ///
    /// - Throws: `Error` if something was wrong with the response
    ///
    func validate(_ response: HttpResponse) throws
}

