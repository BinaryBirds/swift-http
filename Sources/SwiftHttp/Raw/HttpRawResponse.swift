/// A HTTP response object with a raw data value
public struct HttpRawResponse<RawValue>: HttpResponseInterface {

    /// The status code of the response
    public let statusCode: HttpStatusCode

    /// The header fields for the response
    public let headers: [HttpHeaderKey: String]

    /// The raw data value for the response
    public let data: RawValue

    ///
    /// Initialize the response
    ///
    /// - Parameter statusCode: The status code
    /// - Parameter headers: The header fields
    /// - Parameter data: The body data
    ///
    public init(
        statusCode: HttpStatusCode,
        headers: [HttpHeaderKey: String],
        data: RawValue
    ) {
        self.statusCode = statusCode
        self.headers = headers
        self.data = data
    }    
}
