//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation


public struct HttpCodablePipeline<T: Encodable, U: Decodable>: HttpRequestPipeline {
    
    let url: HttpUrl
    let method: HttpMethod
    let headers: [HttpHeaderKey: String]
    let body: T
    let validators: [HttpResponseValidator]
    let encoder: HttpRequestDataEncoder<T>
    let decoder: HttpResponseDataDecoder<U>
    
    public init(url: HttpUrl,
                method: HttpMethod,
                headers: [HttpHeaderKey: String] = [:],
                body: T,
                validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
                encoder: HttpRequestDataEncoder<T>,
                decoder: HttpResponseDataDecoder<U>) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.validators = validators
        self.encoder = encoder
        self.decoder = decoder
    }
    
    public func execute(using client: HttpClient) async throws -> U {
        let req = HttpDataRequest(url: url,
                                  method: method,
                                  headers: headers.merging(encoder.headers) { $1 },
                                  body: try encoder.encode(body))
        
        let response = try await client.request(req)
        let validation = HttpResponseValidation(validators + decoder.validators)
        try validation.validate(response)
        return try decoder.decode(response.data)
    }
}


