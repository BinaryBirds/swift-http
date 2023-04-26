/// A response decoder that can transform the body data into a decodable object and validate the response
public struct HttpResponseDecoder<
    U: Decodable,
    DataDecoder: HttpDataDecoder
>: HttpResponseDecodable {

    /// The response valdators
    public let validators: [HttpResponseValidator]

    let decoder: DataDecoder

    ///
    /// Initialize a response decoder
    ///
    /// - Parameter decoder: The decoder to use for the decoding
    /// - Parameter validators: The array of validators
    ///
    public init(
        decoder: DataDecoder,
        validators: [HttpResponseValidator] = []
    ) {
        self.decoder = decoder
        self.validators = validators
    }

    ///
    /// Decodes the data using the decoder
    ///
    /// - Parameter data: The  HttpRequest to perfrom
    ///
    /// - Throws: `Error` if something was wrong during the decoding
    ///
    /// - Returns: The decoded object
    ///
    public func decode(_ data: DataDecoder.DataType) throws -> U {
        try decoder.decode(U.self, from: data)
    }
}

