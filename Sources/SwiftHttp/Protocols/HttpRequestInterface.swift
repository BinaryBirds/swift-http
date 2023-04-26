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
    
    var cURL: String { get }
}

extension HttpRequestInterface {
    
    public var cURL: String {
        var baseCommand = "\n" + #"curl "\#(url.absolute)""#
        if method == .head {
            baseCommand += " --head"
        }
        var command = [baseCommand]
        if method != .get && method != .head {
            command.append("-X \(method.rawValue.uppercased())")
        }
        for (key, value) in headers where key != .cookie {
            command.append("-H '\(key.rawValue): \(value)'")
        }
        if let body {
            command.append("-d '\(body)'")
        }
        return command.joined(separator: " \\\n\t")
    }
}
