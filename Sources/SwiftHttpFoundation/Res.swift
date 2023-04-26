import Foundation
import SwiftHttp

extension HttpResponseInterface where D == Data {

    /// Converts the response data to a UTF-8 String value
    public var utf8String: String? {
        String(data: data, encoding: .utf8)
    }

    public var traceLogValue: String {
        let prettyHeaders =
            headers
            .map { "\($0.key.rawValue): \($0.value)" }
            .sorted()
            .joined(separator: "\n")

        return """

            \(prettyHeaders)
            \(statusCode.rawValue)
            """
    }
}
