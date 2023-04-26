/// Encodes an encodable object into a HTTP data representation
public protocol HttpDataEncoder {

    /// generic Data type
    associatedtype DataType

    ///
    /// Encodes the object value into raw HTTP data
    ///
    /// - Parameter value: The encodable object instance
    ///
    /// - Throws: `Error` if something was wrong with the encoding
    ///
    /// - Returns: The encoded data value
    ///
    func encode<T>(_ value: T) throws -> DataType where T: Encodable
}
