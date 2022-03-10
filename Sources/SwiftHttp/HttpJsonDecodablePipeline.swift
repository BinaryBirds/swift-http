//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public struct HttpJsonDecodablePipeline<U: Decodable>: HttpRequestPipeline {
    
    let url: HttpUrl
    let method: HttpMethod
    let headers: [String: String]
    let validators: [HttpResponseValidator]
    let decoder: HttpJsonResponseDataDecoder<U>
    
    public init(url: HttpUrl,
                method: HttpMethod,
                headers: [String: String] = [:],
                validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
                decoder: HttpJsonResponseDataDecoder<U> = .init()) {
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
            .header(.accept, "application/json")

        let response = try await client.request(req)
        
        let validation = HttpResponseValidation(validators + [
            HttpHeaderValidator(.contentType) {
                $0.contains("application/json")
            },
        ])
        
        try validation.validate(response)
        
        return try decoder.decode(response.data)
    }
}

