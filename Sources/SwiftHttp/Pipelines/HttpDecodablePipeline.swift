/// A decodable pipeline workflow, to decode a value from the response
public struct HttpDecodablePipeline<
    DataType,
    U: Decodable,
    D: HttpDataDecoder
>: HttpPipelineInterface where DataType == D.DataType {

    let url: HttpUrl
    let method: HttpMethod
    let headers: [HttpHeaderKey: String]
    let body: D.DataType?
    let validators: [HttpResponseValidator]
    let decoder: HttpResponseDecoder<U, D>

    ///
    /// Initialize the pipeline
    ///
    /// - Parameter url: The url to send the request
    /// - Parameter method: The request method
    /// - Parameter headers: The request headers
    /// - Parameter body: The request body as a data value
    /// - Parameter validators: The response validators
    /// - Parameter decoder: The decoder used to decode the response data
    ///
    public init(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: D.DataType? = nil,
        validators: [HttpResponseValidator] = [HttpStatusCodeValidator()],
        decoder: HttpResponseDecoder<U, D>
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.validators = validators
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
    public func execute(
        _ executor: HttpExecutorBlock<DataType>
    ) async throws -> U {
        let req = HttpRawRequest<DataType>(
            method: method,
            url: url,
            headers: headers,
            body: body
        )

        let response = try await executor(req)
        let validation = HttpResponseValidation(validators + decoder.validators)
        try validation.validate(response)
        return try decoder.decode(response.data)
    }
}
