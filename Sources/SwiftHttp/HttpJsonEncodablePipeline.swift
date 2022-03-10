//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public struct HttpJsonEncodablePipeline<T: Encodable>: HttpRequestPipeline {
    
    let url: HttpUrl
    let method: HttpMethod
    let headers: [String: String]
    let body: T
    let validators: [HttpResponseValidator]
    let encoder: HttpJsonRequestDataEncoder<T>
    
    public init(url: HttpUrl,
                method: HttpMethod,
                headers: [String: String] = [:],
                body: T,
                validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
                encoder: HttpJsonRequestDataEncoder<T> = .init()) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.validators = validators
        self.encoder = encoder
    }
    
    public func execute(using client: HttpClient) async throws -> HttpResponse {
        let req = HttpDataRequest(url: url,
                                  method: method,
                                  headers: headers,
                                  body: try encoder.encode(body))
            .header(.contentType, "application/json")
        
        let response = try await client.request(req)
        let validation = HttpResponseValidation(validators)
        try validation.validate(response)
        return response
    }
}
