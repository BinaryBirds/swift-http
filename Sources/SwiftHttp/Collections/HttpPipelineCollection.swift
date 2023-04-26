/// A collection of built-in request pipelines, raw, encodable, decodable, codable
public protocol HttpPipelineCollection {
    associatedtype DataType

    func rawRequest(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String],
        body: DataType?,
        validators: [HttpResponseValidator],
        executor: HttpExecutorBlock<DataType>
    ) async throws -> HttpRawResponse<DataType>
    
    func encodableRequest<T: Encodable, DataEncoder: HttpDataEncoder>(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String],
        body: T,
        validators: [HttpResponseValidator],
        encoder: HttpRequestEncoder<T, DataEncoder>,
        executor: HttpExecutorBlock<DataType>
    ) async throws -> HttpRawResponse<DataType> where DataType == DataEncoder.DataType
    
    func decodableRequest<U: Decodable, DataDecoder: HttpDataDecoder>(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String],
        body: DataType?,
        validators: [HttpResponseValidator],
        decoder: HttpResponseDecoder<U, DataDecoder>,
        executor: HttpExecutorBlock<DataType>
    ) async throws -> U where DataType == DataDecoder.DataType
    
    func codableRequest<T: Encodable, U: Decodable, DataEncoder: HttpDataEncoder, DataDecoder: HttpDataDecoder>(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String],
        body: T,
        validators: [HttpResponseValidator],
        encoder: HttpRequestEncoder<T, DataEncoder>,
        decoder: HttpResponseDecoder<U, DataDecoder>,
        executor: HttpExecutorBlock<DataType>
    ) async throws -> U where DataType == DataEncoder.DataType, DataType == DataDecoder.DataType
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
        executor: HttpExecutorBlock<DataType>
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
        encoder: HttpRequestEncoder<T, DataEncoder>,
        executor: HttpExecutorBlock<DataType>
    ) async throws -> HttpRawResponse<DataType> where DataType == DataEncoder.DataType {
        let pipeline: HttpEncodablePipeline<DataType, T, DataEncoder> = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators,
            encoder: encoder
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
        decoder: HttpResponseDecoder<U, DataDecoder>,
        executor: HttpExecutorBlock<DataType>
    ) async throws -> U where DataType == DataDecoder.DataType {
        let pipeline: HttpDecodablePipeline<DataType, U, DataDecoder> = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators,
            decoder: decoder
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
    public func codableRequest<T: Encodable, U: Decodable, DataEncoder: HttpDataEncoder, DataDecoder: HttpDataDecoder>(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: T,
        validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
        encoder: HttpRequestEncoder<T, DataEncoder>,
        decoder: HttpResponseDecoder<U, DataDecoder>,
        executor: HttpExecutorBlock<DataType>
    ) async throws -> U where DataType == DataEncoder.DataType, DataType == DataDecoder.DataType {
        let pipeline: HttpCodablePipeline<DataType, T, U, DataEncoder, DataDecoder> = .init(
            url: url,
            method: method,
            headers: headers,
            body: body,
            validators: validators,
            encoder: encoder,
            decoder: decoder
        )
        return try await pipeline.execute(executor)
    }
}
