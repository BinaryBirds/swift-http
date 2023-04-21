/// A raw pipeline can be used to send an recieve raw body data values
public struct HttpRawPipeline<DataType>: HttpPipeline {

    let url: HttpUrl
    let method: HttpMethod
    let headers: [HttpHeaderKey: String]
    let body: DataType?
    let validators: [HttpResponseValidator]

    ///
    /// Initialize the pipeline
    ///
    /// - Parameter url: The url to send the request
    /// - Parameter method: The request method
    /// - Parameter headers: The request headers
    /// - Parameter body: The request body as a data value
    /// - Parameter validators: The response validators
    ///
    public init(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String] = [:],
        body: DataType? = nil,
        validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.validators = validators
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
        _ executor: HttpExecutor<DataType>
    ) async throws -> HttpRawResponse<DataType> {
        let req = HttpRawRequest<DataType>(
            url: url,
            method: method,
            headers: headers,
            body: body
        )
        let response = try await executor(req)
        let validation = HttpResponseValidation(validators)
        try validation.validate(response)
        return response
    }
}
