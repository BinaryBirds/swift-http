/// An encodable pipeline can be used to send an encodable object as a request body
public struct HttpEncodablePipeline<
    DataType,
    T: Encodable,
    E: HttpDataEncoder
>: HttpPipeline where DataType == E.DataType {

    let url: HttpUrl
    let method: HttpMethod
    let headers: [HttpHeaderKey: String]
    let body: T
    let validators: [HttpResponseValidator]
    let encoder: HttpRequestEncoder<T, E>

    ///
    /// Initialize the pipeline
    ///
    /// - Parameter url: The url to send the request
    /// - Parameter method: The request method
    /// - Parameter headers: The request headers
    /// - Parameter body: The request body as an encodable value
    /// - Parameter validators: The response validators
    /// - Parameter encoder: The encoder used to encode the body value
    ///
    public init(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: T,
        validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
        encoder: HttpRequestEncoder<T, E>
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.validators = validators
        self.encoder = encoder
    }

    ///
    /// Executes  the request, encodes the body, validates the response and decodes the data
    ///
    /// - Parameter executor: The  executor function to perform the HttpRequest
    ///
    /// - Throws: `Error` if something was wrong
    ///
    /// - Returns: The HTTP response object
    ///
    public func execute(
        _ executor: ((HttpRawRequest<DataType>) async throws -> HttpRawResponse<DataType>)
    ) async throws -> HttpRawResponse<DataType> {
        let req = HttpRawRequest<DataType>(
            url: url,
            method: method,
            headers: headers.merging(encoder.headers) { $1 },
            body: try encoder.encode(body)
        )

        let response = try await executor(req)
        let validation = HttpResponseValidation(validators)
        try validation.validate(response)
        return response
    }
}
