//
//  HttpDecodablePipeline.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public struct HttpDecodablePipeline<U: Decodable>: HttpRequestPipeline {
    
    let url: HttpUrl
    let method: HttpMethod
    let headers: [HttpHeaderKey: String]
    let body: Data?
    let validators: [HttpResponseValidator]
    let decoder: HttpResponseDecoder<U>
    
    public init(url: HttpUrl,
                method: HttpMethod,
                headers: [HttpHeaderKey: String] = [:],
                body: Data? = nil,
                validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
                decoder: HttpResponseDecoder<U>) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.validators = validators
        self.decoder = decoder
    }
    
    public func execute(_ executor: ((HttpRequest) async throws -> HttpResponse)) async throws -> U {
        let req = HttpRawRequest(url: url,
                                  method: method,
                                  headers: headers,
                                  body: body)

        let response = try await executor(req)
        let validation = HttpResponseValidation(validators + decoder.validators)
        try validation.validate(response)
        return try decoder.decode(response.data)
    }
}

