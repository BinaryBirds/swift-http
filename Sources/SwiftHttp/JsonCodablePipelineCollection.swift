//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol JsonCodablePipelineCollection {
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}

public extension JsonCodablePipelineCollection {
    
    
    func data(
        executor: ((HttpRequest) async throws -> HttpResponse),
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: Data? = nil,
        validators: [HttpResponseValidator] = []
    ) async throws -> HttpResponse {
        let pipeline: HttpDataPipeline = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators
        )
        return try await pipeline.execute(executor)
    }

    func encodable<T: Encodable>(
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
            encoder: .json(encoder)
        )
        return try await pipeline.execute(executor)
    }
    
    func decodable<U: Decodable>(
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
            decoder: .json(decoder)
        )
        return try await pipeline.execute(executor)
    }
    
    func codable<T: Encodable, U: Decodable>(
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
                encoder: .json(encoder),
                decoder: .json(decoder)
            )
            return try await pipeline.execute(executor)
        }
}
