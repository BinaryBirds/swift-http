/// A wrapper to store and manipulate URLs in a safer way
public struct HttpUrl: Equatable, Hashable, Codable, CustomStringConvertible {

    /// Scheme of the url, e.g. https
    public var scheme: String

    /// Hostname of the url, e.g. www.localhost.com
    public var host: String

    /// Port of the url, e.g. 80
    public var port: Int

    /// Path components of the url, e.g. `/api/list = ["api", "list"]`
    public var path: [String]

    /// Resource part of the url after the path components, e.g. `sitemap.xml`
    public var resource: String?

    /// Query parameters, e.g. `?foo=bar`
    public var query: [String: String]

    /// Fragment of the url, e.g. `#foo`

    public var fragment: String?

    /// Appends trailing slash at the end of the path, e.g. `localhost.com/any/path/`
    public let isTrailingSlashEnabled: Bool

    ///
    /// Initialize a HttpUrl object
    ///
    /// - Parameter scheme: The  scheme, default: `https`
    /// - Parameter host: The  host
    /// - Parameter port: The  port, default: `80`
    /// - Parameter path: The  path, default: `[]`
    /// - Parameter resource: The  resource, default: `nil`
    /// - Parameter query: The  query, default: `[:]`
    /// - Parameter fragment: The  fragment, default: `nil`
    /// - Parameter trailingSlashEnabled: Sets  ``HttpUrl/isTrailingSlashEnabled``, default: `true`
    ///
    public init(
        scheme: String = "https",
        host: String,
        port: Int = 80,
        path: [String] = [],
        resource: String? = nil,
        query: [String: String] = [:],
        fragment: String? = nil,
        trailingSlashEnabled: Bool = true
    ) {
        self.scheme = scheme
        self.host = host
        self.port = port
        self.path = path
        self.resource = resource
        self.query = query
        self.fragment = fragment
        self.isTrailingSlashEnabled = trailingSlashEnabled
    }

    public var description: String {
        "url.description"
    }
}

public extension HttpUrl {

    ///
    /// Add new scheme to a given url
    ///
    /// - Parameter values: The scheme
    ///
    /// - Returns: A new HttpUrl object
    ///
    func scheme(_ value: String) -> HttpUrl {
        var newUrl = self
        newUrl.scheme = value
        return newUrl
    }

    ///
    /// Add new path components to a given url
    ///
    /// - Parameter values: The path components
    ///
    /// - Returns: A new HttpUrl object
    ///
    func path(_ values: String...) -> HttpUrl {
        var newUrl = self
        newUrl.path = path + values
        return newUrl
    }

    ///
    /// Add new path components to a given url
    ///
    /// - Parameter values: The path components
    ///
    /// - Returns: A new HttpUrl object
    ///
    func path(_ values: [String]) -> HttpUrl {
        var newUrl = self
        newUrl.path = path + values
        return newUrl
    }

    ///
    /// Add new query parameter values to the url
    ///
    /// - Parameter query: The query values
    ///
    /// - Returns: A new HttpUrl object
    ///
    func query(_ query: [String: String?]) -> HttpUrl {
        let finalQuery = query.compactMapValues { $0 }
        var newUrl = self
        newUrl.query = newUrl.query.merging(finalQuery) { $1 }
        return newUrl
    }

    ///
    /// Add a single query parameter value to the url
    ///
    /// - Parameter key: The key of the query param
    /// - Parameter value: The value of the query param
    ///
    /// - Returns: A new HttpUrl object
    ///
    func query(_ key: String, _ value: String?) -> HttpUrl {
        query([key: value])
    }

    ///
    /// Add a new resource part to the url
    ///
    /// - Parameter resource: The resource path component
    ///
    /// - Returns: A new HttpUrl object
    ///
    func resource(_ resource: String) -> HttpUrl {
        var newUrl = self
        newUrl.resource = resource
        return newUrl
    }

    ///
    /// Add a fragment to the url
    ///
    /// - Parameter fragment: The fragment value
    ///
    /// - Returns: A new HttpUrl object
    ///
    func fragment(_ fragment: String) -> HttpUrl {
        var newUrl = self
        newUrl.fragment = fragment
        return newUrl
    }
}
