/// A generic HTTP data decoder
public protocol HttpDataDecoder {
    
    /// generic Data type
    associatedtype DataType

    ///
    /// Decodes the response data into a custom decodable object
    ///
    /// - Parameter type: The type of the decodable object
    /// - Parameter data: The HttpResponse data
    ///
    /// - Throws: `Error` if something was wrong with the decoding
    ///
    /// - Returns: The decoded object
    ///
    func decode<U>(
        _ type: U.Type,
        from data: DataType
    ) throws -> U where U: Decodable
}

