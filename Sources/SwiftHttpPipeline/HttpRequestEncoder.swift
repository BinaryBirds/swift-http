/// A request encoder that can transform an encodable object into a request body and add headers to the request
public struct HttpRequestEncoder<
    T: Encodable,
    DataEncoder: HttpDataEncoder
>: HttpRequestEncodable {

    /// The response valdators
    public let headers: [HttpHeaderKey: String]

    let encoder: DataEncoder

    ///
    /// Initialize a request encoder
    ///
    /// - Parameter encoder: The encoder used to encode the data
    /// - Parameter validators: The additional header fields
    ///
    public init(
        encoder: DataEncoder,
        headers: [HttpHeaderKey: String] = [:]
    ) {
        self.encoder = encoder
        self.headers = headers
    }

    ///
    /// Encodes the content value using the decoder
    ///
    /// - Parameter content: The encodable content
    ///
    /// - Throws: `Error` if something was wrong during the encoding
    ///
    /// - Returns: The encoded data value
    ///
    public func encode(_ content: T) throws -> DataEncoder.DataType {
        try encoder.encode(content)
    }
}
