import Foundation
import SwiftHttp

extension HttpRequest where D == Data {

    /// Converts a HttpRequest to a URLRequest
    public var urlRequest: URLRequest {
        var request = URLRequest(url: url.url)
        request.httpMethod = method.rawValue.uppercased()
        request.httpBody = body
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key.rawValue)
        }
        return request
    }
}
