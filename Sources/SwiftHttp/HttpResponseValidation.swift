//
//  HttpResponseValidation.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public struct HttpResponseValidation {
    
    let validators: [HttpResponseValidator]
    
    public init(_ validators: [HttpResponseValidator]) {
        self.validators = validators
    }

    public func validate(_ response: HttpResponse) throws {
        for validator in validators {
            try validator.validate(response)
        }
    }
}
