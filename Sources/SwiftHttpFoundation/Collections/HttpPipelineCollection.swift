import Foundation
import SwiftHttp

extension HttpPipelineCollection where DataType == Data {

    ///
    /// The generic encoder object used to encode body values
    ///
    /// - Returns: The default json encoder
    ///
//    public func encoder<T: Encodable>() -> any HttpRequestEncoder { .json() }
    
//    public func encoder<T: Encodable, DataEncoder: HttpDataEncoder>() -> HttpRequestEncoder<T, DataEncoder> { .json() }

    ///
    /// The generic decoder object used to decode response data
    ///
    /// - Returns: The default json decoder
    
//    public func decoder<T: Decodable>() -> any HttpResponseDecoder { .json() }
    
}
