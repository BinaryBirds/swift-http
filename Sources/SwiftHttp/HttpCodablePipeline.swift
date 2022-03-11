//
//  HttpCodablePipeline.swift
//  SwiftHttp
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
    let encoder: HttpRequestEncoder<T>
    let decoder: HttpResponseDecoder<U>
    
    public init(url: HttpUrl,
                method: HttpMethod,
                headers: [HttpHeaderKey: String] = [:],
                body: T,
                validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
                encoder: HttpRequestEncoder<T>,
                decoder: HttpResponseDecoder<U>) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.validators = validators
        self.encoder = encoder
        self.decoder = decoder
    }
    
    public func execute(_ executor: ((HttpRequest) async throws -> HttpResponse)) async throws -> U {
        let req = HttpRawRequest(url: url,
                                  method: method,
                                  headers: headers.merging(encoder.headers) { $1 },
                                  body: try encoder.encode(body))
        
        let response = try await executor(req)
        let validation = HttpResponseValidation(validators + decoder.validators)
        try validation.validate(response)
        return try decoder.decode(response.data)
    }
}


