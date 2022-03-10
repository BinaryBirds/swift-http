//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpStatusCodeValidator: HttpResponseValidator {
    
    let code: HttpStatusCode?
    
    // if code nil -> default validation 200..<300
    public init(_ code: HttpStatusCode? = nil) {
        self.code = code
    }

    public func validate(_ response: HttpResponse) throws {
        if let code = code, response.statusCode != code {
            throw HttpError.statusCode(response.statusCode)
        }
        //TODO: check code == nil
        guard response.statusCode.isValid else {
            throw HttpError.statusCode(response.statusCode)
        }
    }
}

