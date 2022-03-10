//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public struct HttpDecodablePipeline<U: Decodable>: HttpRequestPipeline {
    
    let url: HttpUrl
    let method: HttpMethod
    let headers: [HttpHeaderKey: String]
    let validators: [HttpResponseValidator]
    let decoder: HttpResponseDataDecoder<U>
    
    public init(url: HttpUrl,
                method: HttpMethod,
                headers: [HttpHeaderKey: String] = [:],
                validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
                decoder: HttpResponseDataDecoder<U>) {
        self.url = url
        self.method = method
        self.headers = headers
        self.validators = validators
        self.decoder = decoder
    }
    
    public func execute(using client: HttpClient) async throws -> U {
        let req = HttpDataRequest(url: url,
                                  method: method,
                                  headers: headers)

        let response = try await client.request(req)
        let validation = HttpResponseValidation(validators + decoder.validators)
        try validation.validate(response)
        return try decoder.decode(response.data)
    }
}

