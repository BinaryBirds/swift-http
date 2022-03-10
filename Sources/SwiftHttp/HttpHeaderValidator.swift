//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public struct HttpHeaderValidator: HttpResponseValidator {
    
    let key: HttpHeaderKey
    let block: (String) -> Bool
    
    public init(_ key: HttpHeaderKey, _ block: @escaping ((String) -> Bool)) {
        self.key = key
        self.block = block
    }

    public func validate(_ response: HttpResponse) throws {
        guard let value = response.headers[key] else {
            throw HttpError.missingHeader(response)
        }
        guard block(value) else {
            throw HttpError.invalidHeaderValue(response)
        }
    }
}

