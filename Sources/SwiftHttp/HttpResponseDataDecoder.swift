//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpResponseDataDecoder<T: Decodable>: HttpResponseDataTransformer {

    public let validators: [HttpResponseValidator]
    let decoder: HttpDataDecoder

    public init(decoder: HttpDataDecoder, validators: [HttpResponseValidator] = []) {
        self.decoder = decoder
        self.validators = validators
    }

    public func decode(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}

public extension HttpResponseDataDecoder {
    
    static func json(_ decoder: JSONDecoder = .init(),
                     validators: [HttpResponseValidator] = [
                         HttpHeaderValidator(.key(.contentType)) {
                             $0.contains("application/json")
                         },
                     ]) -> HttpResponseDataDecoder {
        .init(decoder: decoder, validators: validators)
    }
}
