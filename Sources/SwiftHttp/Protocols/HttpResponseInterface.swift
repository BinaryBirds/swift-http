/// A generic HttpResponse object
public protocol HttpResponseInterface {
    
    /// generic response type
    associatedtype D

    /// The HTTP status code of the response
    var statusCode: HttpStatusCode { get }

    /// The HTTP response headers
    var headers: [HttpHeaderKey: String] { get }

    /// The HTTP response data
    var data: D { get }
}

