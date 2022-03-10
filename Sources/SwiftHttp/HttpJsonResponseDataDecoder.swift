//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpJsonResponseDataDecoder<T: Decodable>: HttpResponseDataDecoder {

    let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }

    public func decode(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}

