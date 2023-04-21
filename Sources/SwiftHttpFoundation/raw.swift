import Foundation
import SwiftHttp

extension HttpRawResponse where RawValue == Data {
    
    ///
    /// Initialize the response
    ///
    /// - Parameter tuple: A tuple value with a Data, URLResponse type
    ///
    /// - Throws: `HttpError` if something was wrong with the tuple values
    ///

    public init(_ tuple: (Data, URLResponse)) throws {
        guard let response = tuple.1 as? HTTPURLResponse else {
            throw HttpError.invalidResponse
        }
        var headers: [HttpHeaderKey: String] = [:]
        for header in response.allHeaderFields {
            let key = String(describing: header.key)
            let value = String(describing: header.value)
            let headerKey: HttpHeaderKey = .custom(key)
            headers[headerKey] = value
        }
        guard let statusCode = HttpStatusCode(rawValue: response.statusCode)
        else {
            throw HttpError.unknownStatusCode
        }
        self.init(statusCode: statusCode, headers: headers, data: tuple.0)
    }

}
