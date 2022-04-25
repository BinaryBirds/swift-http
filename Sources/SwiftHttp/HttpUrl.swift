//
//  HttpUrl.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

/// A wrapper to store and manipulate URLs in a safer way
public struct HttpUrl {
    
    /// Scheme of the url, e.g. https
    public private(set) var scheme: String
    
    /// Hostname of the url, e.g. www.localhost.com
    public private(set) var host: String
    
    /// Port of the url, e.g. 80
    public private(set) var port: Int
    
    /// Path components of the url, e.g. `/api/list = ["api", "list"]`
    public private(set) var path: [String]
    
    /// Resource part of the url after the path components, e.g. `sitemap.xml`
    public private(set) var resource: String?
    
    /// Query parameters, e.g. `?foo=bar`
    public private(set) var query: [String: String]
    
    /// Fragment of the url, e.g. `#foo`
    public private(set) var fragment: String?

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
    ///
    public init(scheme: String = "https",
                host: String,
                port: Int = 80,
                path: [String] = [],
                resource: String? = nil,
                query: [String : String] = [:],
                fragment: String? = nil) {
        self.scheme = scheme
        self.host = host
        self.port = port
        self.path = path
        self.resource = resource
        self.query = query
        self.fragment = fragment
    }
}

public extension HttpUrl {

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
    
    // MARK: - URL

    /// Returns the URL representation of the HttpUrl object
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        var path = "/" + path.joined(separator: "/")
        if let resource = resource {
            path += (resource.hasPrefix("/") ? resource : "/" + resource)
        } else {
            path += "/"
        }
				if path.last == "/", !query.isEmpty {
						path.removeLast()
				}
        components.path = path
        components.fragment = fragment
        components.queryItems = query.map { .init(name: $0.key, value: $0.value) }
        if let items = components.queryItems, items.isEmpty {
            components.queryItems = nil
        }
        if components.port == 80 {
            components.port = nil
        }
        guard let url = components.url else {
            fatalError("Invalid URL components \(components)")
        }
        return url
    }
}

extension HttpUrl {
	
	/// Initialize a `HttpUrl` object with `string`
	///
	/// Returns `nil` if a `HttpUrl` cannot be formed with the string (for example, if the string contains characters that are illegal in a URL, or is an empty string).
	public init?(string: String) {
		if let url = URL(string: string) {
			self.init(url: url)
		} else {
			return nil
		}
	}
	
	/// Initialize a `HttpUrl` object with `URL` object
	///
	/// Returns `nil` if a `HttpUrl` cannot be formed with the `URL` (for example, if the string contains characters that are illegal in a URL, or is an empty string).
	public init?(url: URL) {
		guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
		var path = components.path.trimmingCharacters(in: CharacterSet(charactersIn: "/")).components(separatedBy: "/")
		let resource: String?
		if path.last?.contains(".") == true {
			resource = path.removeLast()
		} else {
			resource = nil
		}
		self.init(
			scheme: components.scheme ?? "https",
			host: components.host ?? "",
			port: components.port ?? 80,
			path: path,
			resource: resource,
			query: components.queryItems.map({ Dictionary($0.map({ ($0.name, $0.value ?? "") })) { _, s in s } }) ?? [:],
			fragment: components.fragment
		)
	}
}

infix operator /?: MultiplicationPrecedence

public func /(_ lhs: String, _ rhs: String) -> HttpUrl {
	HttpUrl(scheme: lhs, host: rhs)
}

public func /(_ lhs: HttpUrl, _ rhs: String) -> HttpUrl {
	lhs.path(rhs)
}

public func /?(_ lhs: HttpUrl, _ rhs: [String: String?]) -> HttpUrl {
	lhs.query(rhs)
}
