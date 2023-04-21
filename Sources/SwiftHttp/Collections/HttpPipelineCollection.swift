/// A collection of built-in request pipelines, raw, encodable, decodable, codable
public protocol HttpPipelineCollection {

    associatedtype DataType
    ///
    /// The generic encoder object used to encode body values
    ///
    /// - Returns: The generic request encoder instance
    ///
    func encoder<T: Encodable, DataEncoder: HttpDataEncoder>() -> HttpRequestEncoder<T, DataEncoder>

    ///
    /// The generic decoder object used to decode response data
    ///
    /// - Returns: The generic response decoder
    ///
    func decoder<T: Decodable, DataDecoder: HttpDataDecoder>() -> HttpResponseDecoder<T, DataDecoder>
}

extension HttpPipelineCollection {

    ///
    /// Executes a raw request pipeline using a data values as a body and returns the response
    ///
    /// - Parameter executor: The  executor function to perform the HttpRequest
    /// - Parameter url: The url to send the request
    /// - Parameter method: The request method
    /// - Parameter headers: The request headers
    /// - Parameter body: The request body as a data value
    /// - Parameter validators: The response validators
    ///
    /// - Throws: `Error` if something was wrong
    ///
    /// - Returns: The HTTP response object
    ///
    public func rawRequest(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: DataType? = nil,
        validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
        executor: HttpExecutor<DataType>
    ) async throws -> HttpRawResponse<DataType> {
        let pipeline: HttpRawPipeline<DataType> = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators
        )
        return try await pipeline.execute(executor)
    }

    ///
    /// Executes an encodable request pipeline using an encodable object as a body value and returns the response
    ///
    /// - Parameter executor: The  executor function to perform the HttpRequest
    /// - Parameter url: The url to send the request
    /// - Parameter method: The request method
    /// - Parameter headers: The request headers
    /// - Parameter body: The request body as an encodable object
    /// - Parameter validators: The response validators
    ///
    /// - Throws: `Error` if something was wrong
    ///
    /// - Returns: The HTTP response object
    ///
    public func encodableRequest<T: Encodable, DataEncoder: HttpDataEncoder>(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: T,
        validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
        encoder: HttpRequestEncoder<T, DataEncoder>? = nil,
        executor: HttpExecutor<DataType>
    ) async throws -> any HttpResponse where DataType == DataEncoder.DataType {
        let pipeline: HttpEncodablePipeline<DataType, T, DataEncoder> = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators,
            encoder: encoder ?? self.encoder()
        )
        return try await pipeline.execute(executor)
    }

    ///
    /// Executes a raw request pipeline using a data values as a body and returns the response
    ///
    /// - Parameter executor: The  executor function to perform the HttpRequest
    /// - Parameter url: The url to send the request
    /// - Parameter method: The request method
    /// - Parameter headers: The request headers
    /// - Parameter body: The request body as a data value
    /// - Parameter validators: The response validators
    ///
    /// - Throws: `Error` if something was wrong
    ///
    /// - Returns: The decoded response object
    ///
    public func decodableRequest<U: Decodable, DataDecoder: HttpDataDecoder>(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: DataType? = nil,
        validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
        decoder: HttpResponseDecoder<U, DataDecoder>? = nil,
        executor: HttpExecutor<DataType>
    ) async throws -> U where DataType == DataDecoder.DataType {
        let pipeline: HttpDecodablePipeline<DataType, U, DataDecoder> = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators,
            decoder: decoder ?? self.decoder()
        )
        return try await pipeline.execute(executor)
    }

    ///
    /// Executes a codable request pipeline using an encodable body and decodes the response
    ///
    /// - Parameter executor: The  executor function to perform the HttpRequest
    /// - Parameter url: The url to send the request
    /// - Parameter method: The request method
    /// - Parameter headers: The request headers
    /// - Parameter body: The request body as an encodable value
    /// - Parameter validators: The response validators
    ///
    /// - Throws: `Error` if something was wrong
    ///
    /// - Returns: The decoded response object
    ///
    public func codableRequest<T: Encodable, U: Decodable, DataCoder: HttpDataCoder>(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: T,
        validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
        encoder: HttpRequestEncoder<T, DataCoder>? = nil,
        decoder: HttpResponseDecoder<U, DataCoder>? = nil,
        executor: HttpExecutor<DataType>
    ) async throws -> U where DataType == DataCoder.DataType {
        let pipeline: HttpCodablePipeline<DataType, T, U, DataCoder, DataCoder> = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators,
            encoder: encoder ?? self.encoder(),
            decoder: decoder ?? self.decoder()
        )
        return try await pipeline.execute(executor)
    }
}
