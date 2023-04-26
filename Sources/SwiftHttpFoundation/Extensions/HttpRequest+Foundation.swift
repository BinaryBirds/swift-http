import Foundation
import SwiftHttp

extension HttpRawRequest where D == Data {

    /// Converts a HttpRequest to a URLRequest
    var foundationRequest: URLRequest? {
        guard let url = url.foundationUrl else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.httpBody = body
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key.rawValue)
        }
        return request
    }
}
