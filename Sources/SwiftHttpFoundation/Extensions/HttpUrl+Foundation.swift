import Foundation
import SwiftHttp

extension HttpUrl {

    /// Returns the URL representation of the HttpUrl object
    var foundationUrl: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.user = user
        components.password = pass
        components.host = host
        components.port = port
        
        var safePath = "/"
        if let path, !path.isEmpty {
            if path.hasPrefix("/") {
                safePath += String(path.dropFirst())
            }
            else {
                safePath += path
            }
        }

        components.path = safePath
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
        return components.url
    }
}
