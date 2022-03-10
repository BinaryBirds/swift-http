//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public struct HttpDataPipeline: HttpRequestPipeline {
    
    let url: HttpUrl
    let method: HttpMethod
    let headers: [String: String]
    let body: Data?
    let validators: [HttpResponseValidator]
    
    public init(url: HttpUrl,
                method: HttpMethod,
                headers: [String: String] = [:],
                body: Data? = nil,
                validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.validators = validators
    }
    
    public func execute(using client: HttpClient) async throws -> HttpResponse {
        let req = HttpDataRequest(url: url, method: method, headers: headers, body: body)
        let response = try await client.request(req)
        let validation = HttpResponseValidation(validators)
        try validation.validate(response)
        return response
    }
}

