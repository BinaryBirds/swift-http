//
//  HttpCodablePipeline.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// A fully Codable HTTP request pipeline, where the req body is encodable and the response is decodable
public struct HttpCodablePipeline<T: Encodable, U: Decodable>: HttpRequestPipeline {
    
    let url: HttpUrl
    let method: HttpMethod
    let headers: [HttpHeaderKey: String]
    let body: T
    let validators: [HttpResponseValidator]
    let encoder: HttpRequestEncoder<T>
    let decoder: HttpResponseDecoder<U>
    
    ///
    /// Init a new codable pipeline
    ///
    /// - Parameter url: The url to send the request
    /// - Parameter method: The HTTP method used to perform the request
    /// - Parameter headers: The headers to send
    /// - Parameter body: The request body as an encodable object
    /// - Parameter validators: The response validators, by default checks for a valid status code
    /// - Parameter encoder: The request data encoder object
    /// - Parameter decoder: The response data decoder object
    ///
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
    
    ///
    /// Executes  the request, encodes the body, validates the response and decodes the data
    ///
    /// - Parameter executor: The  executor function to perform the HttpRequest
    ///
    /// - Throws: `Error` if something was wrong
    ///
    /// - Returns: The decoded response object
    ///
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


