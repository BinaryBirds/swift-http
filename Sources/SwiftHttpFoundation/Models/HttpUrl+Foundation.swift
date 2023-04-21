import Foundation
import SwiftHttp

extension HttpUrl {

    /// Initialize a `HttpUrl` object with `string`
    ///
    /// Returns `nil` if a `HttpUrl` cannot be formed with the string (for example, if the string contains characters that are illegal in a URL, or is an empty string).
    public init?(string: String) {
        if let url = URL(string: string) {
            self.init(url: url)
        }
        else {
            return nil
        }
    }
    
    /// Initialize a `HttpUrl` object with `URL` object
    ///
    /// Returns `nil` if a `HttpUrl` cannot be formed with the `URL` (for example, if the string contains characters that are illegal in a URL, or is an empty string).
    public init?(url: URL) {
        guard
            let components = URLComponents(
                url: url,
                resolvingAgainstBaseURL: true
            )
        else { return nil }
        var path = components.path.trimmingCharacters(
            in: CharacterSet(charactersIn: "/")
        ).components(separatedBy: "/")
        let resource: String?
        if path.last?.contains(".") == true {
            resource = path.removeLast()
        }
        else {
            resource = nil
        }
        self.init(
            scheme: components.scheme ?? "https",
            host: components.host ?? "",
            port: components.port ?? 80,
            path: path,
            resource: resource,
            query: components.queryItems.map({
                Dictionary($0.map({ ($0.name, $0.value ?? "") })) { _, s in s }
            }) ?? [:],
            fragment: components.fragment
        )
    }

    /// Returns the URL representation of the HttpUrl object
    public var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        var path = "/" + path.joined(separator: "/")

        if let resource = resource {
            path += (resource.hasPrefix("/") ? resource : "/" + resource)
        }
        else {
            if isTrailingSlashEnabled {
                path += "/"
            }
        }
        components.path = path
        components.fragment = fragment
        components.queryItems = query.map {
            .init(name: $0.key, value: $0.value)
        }
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
