//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol HttpCodablePipelineCollection {

    func encoder<T: Encodable>() -> HttpRequestEncoder<T>
    func decoder<T: Decodable>() -> HttpResponseDecoder<T>
}

public extension HttpCodablePipelineCollection {
    
    
    func rawRequest(
        executor: ((HttpRequest) async throws -> HttpResponse),
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: Data? = nil,
        validators: [HttpResponseValidator] = []
    ) async throws -> HttpResponse {
        let pipeline: HttpRawPipeline = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators
        )
        return try await pipeline.execute(executor)
    }
    
    func encodableRequest<T: Encodable>(
        executor: ((HttpRequest) async throws -> HttpResponse),
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: T,
        validators: [HttpResponseValidator] = []
    ) async throws -> HttpResponse {
        let pipeline: HttpEncodablePipeline<T> = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators,
            encoder: encoder()
        )
        return try await pipeline.execute(executor)
    }
    
    func decodableRequest<U: Decodable>(
        executor: ((HttpRequest) async throws -> HttpResponse),
        url: HttpUrl,
        method: HttpMethod,
        body: Data? = nil,
        headers: [HttpHeaderKey: String] = [:],
        validators: [HttpResponseValidator] = []
    ) async throws -> U {
        let pipeline: HttpDecodablePipeline<U> = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators,
            decoder: decoder()
        )
        return try await pipeline.execute(executor)
    }
    
    func codableRequest<T: Encodable, U: Decodable>(
        executor: ((HttpRequest) async throws -> HttpResponse),
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: T,
        validators: [HttpResponseValidator] = []) async throws -> U {
            let pipeline: HttpCodablePipeline<T, U> = .init(
                url: url,
                method: method,
                headers: headers,
                body: body,
                validators: validators,
                encoder: encoder(),
                decoder: decoder()
            )
            return try await pipeline.execute(executor)
        }
}
