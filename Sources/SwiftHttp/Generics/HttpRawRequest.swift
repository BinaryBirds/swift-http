/// A HTTP request with a raw body data
public struct HttpRawRequest<RawValue>: HttpRequest {

    /// The method to use when sending the request
    public let method: HttpMethod

    /// The url to send the request
    public let url: HttpUrl

    /// The HTTP header fields for the request
    public let headers: [HttpHeaderKey: String]

    /// The HTTP body as a raw data value
    public let body: RawValue?

    ///
    /// Initialize the request
    ///
    /// - Parameter url: The url to send the request
    /// - Parameter method: The request method
    /// - Parameter headers: The request headers
    /// - Parameter body: The request body as a data value
    ///
    public init(
        url: HttpUrl,
        method: HttpMethod = .get,
        headers: [HttpHeaderKey: String] = [:],
        body: RawValue? = nil
    ) {
        self.method = method
        self.url = url
        self.headers = headers
        self.body = body
    }
}

public extension HttpRawRequest {

    ///
    /// Change the method of the request
    ///
    /// - Parameter method: The new method value
    ///
    /// - Returns: A new request object with the updated method
    ///
    func method(_ method: HttpMethod) -> HttpRawRequest {
        .init(url: url, method: method, headers: headers, body: body)
    }
    
    ///
    /// Change the url of the request
    ///
    /// - Parameter url: The new url value
    ///
    /// - Returns: A new request object with the updated url
    ///
    func url(_ url: HttpUrl) -> HttpRawRequest {
        .init(url: url, method: method, headers: headers, body: body)
    }

    ///
    /// Add a new header value to the request
    ///
    /// - Parameter key: The query values
    /// - Parameter value: The query values
    ///
    /// - Returns: A new request object with the updated headers
    ///
    func header(_ key: HttpHeaderKey, _ value: String) -> HttpRawRequest {
        var newHeaders = headers
        newHeaders[key] = value
        return .init(url: url, method: method, headers: newHeaders, body: body)
    }

    ///
    /// Set a new body value for the request
    ///
    /// - Parameter body: The raw data value for the body
    ///
    /// - Returns: A new request object with the updated body value
    ///
    func body<Body>(_ body: Body) -> HttpRawRequest<Body> {
        .init(url: url, method: method, headers: headers, body: body)
    }
}
