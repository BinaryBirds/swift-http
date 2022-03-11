//
//  HttpRawPipeline.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public struct HttpRawPipeline: HttpRequestPipeline {
    
    let url: HttpUrl
    let method: HttpMethod
    let headers: [HttpHeaderKey: String]
    let body: Data?
    let validators: [HttpResponseValidator]
    
    public init(url: HttpUrl,
                method: HttpMethod,
                headers: [HttpHeaderKey: String] = [:],
                body: Data? = nil,
                validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.validators = validators
    }
    
    public func execute(_ executor: ((HttpRequest) async throws -> HttpResponse)) async throws -> HttpResponse {
        let req = HttpRawRequest(url: url, method: method, headers: headers, body: body)
        let response = try await executor(req)
        let validation = HttpResponseValidation(validators)
        try validation.validate(response)
        return response
    }
}

