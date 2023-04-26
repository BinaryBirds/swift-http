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
    
//    var logValue: String { get }
//    var traceLogValue: String { get }
}

//public extension HttpResponseInterface {
//
//    var logValue: String {
//        ""
//    }
//
//    var traceLogValue: String {
//        let prettyHeaders =
//            headers
//            .map { "\($0.key.rawValue): \($0.value)" }
//            .sorted()
//            .joined(separator: "\n")
//
//        return """
//            \(prettyHeaders)
//            \(statusCode.rawValue)
//            """
//    }
//}
