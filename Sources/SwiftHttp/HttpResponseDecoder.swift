//
//  HttpResponseDecoder.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpResponseDecoder<T: Decodable>: HttpResponseTransformer {

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

public extension HttpResponseDecoder {
    
    static func json(_ decoder: JSONDecoder = .init(),
                     validators: [HttpResponseValidator] = [
                         HttpHeaderValidator(.key(.contentType)) {
                             $0.contains("application/json")
                         },
                     ]) -> HttpResponseDecoder {
        .init(decoder: decoder, validators: validators)
    }
}
