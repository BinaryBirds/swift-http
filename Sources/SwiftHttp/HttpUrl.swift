//
//  HttpUrl.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpUrl {
    
    public private(set) var scheme: String
    public private(set) var host: String
    public private(set) var port: Int
    public private(set) var path: [String]
    public private(set) var resource: String?
    public private(set) var query: [String: String]
    public private(set) var fragment: String?

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

    /// add a new path to the url
    func path(_ values: String...) -> HttpUrl {
        var newUrl = self
        newUrl.path = path + values
        return newUrl
    }

    func query(_ query: [String: String?]) -> HttpUrl {
        let finalQuery = query.compactMapValues { $0 }
        var newUrl = self
        newUrl.query = newUrl.query.merging(finalQuery) { $1 }
        return newUrl
    }

    func query(_ key: String, _ value: String?) -> HttpUrl {
        query([key: value])
    }
    
    func resource(_ resource: String) -> HttpUrl {
        var newUrl = self
        newUrl.resource = resource
        return newUrl
    }
    
    func fragment(_ fragment: String) -> HttpUrl {
        var newUrl = self
        newUrl.fragment = fragment
        return newUrl
    }
    
    // MARK: - URL

    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        var path = "/" + path.joined(separator: "/")
        if let resource = resource {
            path += (resource.hasPrefix("/") ? resource : "/" + resource)
        }
        else {
            path += "/"
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
