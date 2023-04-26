import Foundation
import SwiftHttp

extension HttpRequestEncoder where DataEncoder.DataType == Data {

    ///
    /// Initialize a JSON request encoder
    ///
    /// - Parameter encoder: The JSONEncoder object to use, the default is the built in JSONEncoder
    /// - Parameter headers: The default accept and content type headers for a JSON request
    ///
    public static func json(
        _ encoder: DataEncoder = JSONEncoder(),
        headers: [HttpHeaderKey: String] = [
            .accept: "application/json",
            .contentType: "application/json",
        ]
    ) -> HttpRequestEncoder<T, DataEncoder> {
        .init(encoder: encoder, headers: headers)
    }
}
