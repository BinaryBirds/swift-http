import Foundation
import SwiftHttp

extension HttpResponseDecoder where DataDecoder.DataType == Data {

    ///
    /// Initialize a JSON response decoder
    ///
    /// - Parameter decoder: The JSONDecoder object to use, the default is the built in JSONDecoder
    /// - Parameter validators: The array of validators, by default it validates the content type
    ///
    public static func json<U>(
        _ decoder: DataDecoder = JSONDecoder(),
        validators: [HttpResponseValidator] = [
            HttpHeaderValidator(.contentType) {
                $0.contains("application/json")
            }
        ]
    ) -> HttpResponseDecoder<U, DataDecoder> {
        .init(decoder: decoder, validators: validators)
    }
}
