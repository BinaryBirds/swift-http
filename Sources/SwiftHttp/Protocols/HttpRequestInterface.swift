/// A HttpRequest representation
public protocol HttpRequestInterface {
    
    /// generic response type
    associatedtype D

    /// HTTP method of the request
    var method: HttpMethod { get }

    /// URL of the request
    var url: HttpUrl { get }

    /// Header fields for the request
    var headers: [HttpHeaderKey: String] { get }

    /// HTTP body as a data representation
    var body: D? { get }
}
