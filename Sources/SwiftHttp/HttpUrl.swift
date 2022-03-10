//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public struct HttpUrl {
    
    public let scheme: String
    public let port: Int
    public let domain: String
    public let path: [String]
    public let resource: String?
    public let params: [String: String]
    public let fragment: String?

    public init(scheme: String = "https",
                port: Int = 80,
                domain: String,
                path: [String] = [],
                resource: String? = nil,
                params: [String : String] = [:],
                fragment: String? = nil) {
        self.scheme = scheme
        self.port = port
        self.domain = domain
        self.path = path
        self.resource = resource
        self.params = params
        self.fragment = fragment
    }
}

public extension HttpUrl {

    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = domain
        components.port = port
        components.path = "/" + path.joined(separator: "/") + "/" + (resource ?? "")
        components.fragment = fragment
        components.queryItems = params.map { .init(name: $0.key, value: $0.value) }
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
    
    /// add a new path to the url
    func path(_ values: String...) -> HttpUrl {
        .init(scheme: scheme,
              port: port,
              domain: domain,
              path: path + values,
              resource: resource,
              params: params,
              fragment: fragment)
    }
}
