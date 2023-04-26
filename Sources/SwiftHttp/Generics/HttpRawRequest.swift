/// A HTTP request with a raw body data
public struct HttpRawRequest<RawValue>: HttpRequestInterface {

    /// The method to use when sending the request
    public var method: HttpMethod

    /// The url to send the request
    public var url: HttpUrl

    /// The HTTP header fields for the request
    public var headers: [HttpHeaderKey: String]

    /// The HTTP body as a raw data value
    public var body: RawValue?

    ///
    /// Initialize the request
    ///
    /// - Parameter url: The url to send the request
    /// - Parameter method: The request method
    /// - Parameter headers: The request headers
    /// - Parameter body: The request body as a data value
    ///
    public init(
        method: HttpMethod = .get,
        url: HttpUrl,
        headers: [HttpHeaderKey: String] = [:],
        body: RawValue? = nil
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}
