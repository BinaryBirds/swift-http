private extension String {
    
    func trimmingSlashes() -> String {
        var res = self
        if res.hasPrefix("/") {
            res = String(res.dropFirst())
        }
        if res.hasSuffix("/") {
            res = String(res.dropLast())
        }
        return res
    }
    
    func hasExtension() -> Bool {
        let res = split(separator: "/")
        return res.last?.contains(".") ?? false
    }
}

/// A wrapper to store and manipulate URLs in a safer way
public struct HttpUrl: Equatable, Hashable, Codable, CustomStringConvertible {

    /// Scheme of the url, e.g. https
    public var scheme: String

    /// user
    public var user: String?

    /// password
    public var pass: String?
    
    /// Hostname of the url, e.g. www.localhost.com
    public var host: String

    /// Port of the url, e.g. 80
    public var port: Int

    /// Path of the url
    public var path: String?

    /// Query parameters, e.g. `?foo=bar`
    public var query: [String: String?]

    /// Fragment of the url, e.g. `#foo`

    public var fragment: String?


    ///
    /// Initialize a HttpUrl object
    ///
    /// - Parameter scheme: The  scheme, default: `https`
    /// - Parameter user: The  user
    /// - Parameter pass: The  password
    /// - Parameter host: The  host
    /// - Parameter port: The  port, default: `80`
    /// - Parameter path: The  path, default: `[]`
    /// - Parameter query: The  query, default: `[:]`
    /// - Parameter fragment: The  fragment, default: `nil`
    ///
    public init(
        scheme: String = "https",
        user: String? = nil,
        pass: String? = nil,
        host: String,
        port: Int = 80,
        path: String? = nil,
        resource: String? = nil,
        query: [String: String] = [:],
        fragment: String? = nil
    ) {
        self.scheme = scheme
        self.user = user
        self.pass = pass
        self.host = host
        self.port = port
        self.path = path
        self.query = query
        self.fragment = fragment
    }

    public var absolute: String {
        var result = scheme + "://"
        if let user, !user.isEmpty {
            result += user
            if let pass, !pass.isEmpty {
                result += ":" + pass
            }
            result += "@"
        }

        result += host.trimmingSlashes()
        if port != 80 {
            result += ":" + String(port)
        }

        if let path, !path.isEmpty {
            if !path.hasPrefix("/") {
                result += "/"
            }
            result += path
        }

        if !query.isEmpty {
            result += "?" + query
                .map { $0.key + "=" + ($0.value ?? "") }
                .joined(separator: "&")
        }

        if let fragment, !fragment.isEmpty {
            result += "#" + fragment
        }
        return result
    }

    public var description: String {
        absolute
    }
}

public extension HttpUrl {
    
    mutating func appendingPath(_ value: String) {
        path = (path ?? "") + value
    }
    
    func appendPath(_ value: String) -> HttpUrl {
        var url = self
        url.path = (url.path ?? "") + value
        return url
    }

    ///
    /// Add new path components to a given url
    ///
    /// - Parameter values: The path components
    ///
    mutating func appendingPathComponents(_ values: [String]) {
        path = (path ?? "") + values.joined(separator: "/")
    }

    ///
    /// Add new path components to a given url
    ///
    /// - Parameter values: The path components
    ///
    mutating func appendingPathComponents(_ values: String...) {
        appendingPathComponents(values)
    }
    
    func appendPathComponents(_ values: String...) -> HttpUrl {
        var url = self
        url.appendingPathComponents(values)
        return url
    }
    
    func appendPathComponents(_ values: [String]) -> HttpUrl {
        var url = self
        url.appendingPathComponents(values)
        return url
    }

    ///
    /// Add new query parameter values to the url
    ///
    /// - Parameter query: The query values
    ///
    mutating func appendingQueryParameters(_ parameters: [String: String?]) {
        let finalQuery = parameters.compactMapValues { $0 }
        query = query.merging(finalQuery) { $1 }
    }
    
    func appendQueryParameters(_ parameters: [String: String?]) -> HttpUrl {
        var url = self
        url.appendingQueryParameters(parameters)
        return url
    }

    ///
    /// Add a single query parameter value to the url
    ///
    /// - Parameter key: The key of the query param
    /// - Parameter value: The value of the query param
    ///
    mutating func appendingQueryParameter(_ key: String, _ value: String?) {
        appendingQueryParameters([key: value])
    }
    
    func appendQueryParameter(_ key: String, _ value: String?) -> HttpUrl {
        var url = self
        url.appendingQueryParameters([key: value])
        return url
    }
}
