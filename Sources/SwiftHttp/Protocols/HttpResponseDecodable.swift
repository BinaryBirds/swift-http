/// Transforms a given response into a decodable object and validates it upfront
public protocol HttpResponseDecodable {

    /// The decodable object type
    associatedtype T: Decodable
    associatedtype D

    /// Validators to perform before the decoding
    var validators: [HttpResponseValidator] { get }

    ///
    /// Decodes the response data into a custom decodable object
    ///
    /// - Parameter data: The HttpResponse data
    ///
    /// - Throws: `Error` if something was wrong with the decoding
    ///
    /// - Returns: The decoded object
    ///
    func decode(_ data: D) throws -> T
}
