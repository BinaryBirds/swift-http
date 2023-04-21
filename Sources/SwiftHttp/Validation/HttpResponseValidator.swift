/// A generic response validator protocol
public protocol HttpResponseValidator {

    ///
    /// Validates a response object
    ///
    /// - Parameter response: The HTTP response
    ///
    /// - Throws: `Error` if something was wrong with the response
    ///
    func validate(_ response: any HttpResponse) throws
}
