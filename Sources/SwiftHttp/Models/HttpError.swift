/// A generic error object to transfer HTTP related error messages
public enum HttpError: Error {

    /// The request is invalid for some reason
    case invalidRequest
    
    /// The response is not a valid HTTP response
    case invalidResponse

    /// The response has a unknown status code
    case unknownStatusCode

    /// The response has an invalid status code
    case invalidStatusCode(any HttpResponseInterface)

    /// The response is missing a header
    case missingHeader(any HttpResponseInterface)

    /// The response has an invalid header value
    case invalidHeaderValue(any HttpResponseInterface)

    /// Upload request does not have data to send
    case missingUploadData

    /// Unknown error
    case unknown(Error)
}
