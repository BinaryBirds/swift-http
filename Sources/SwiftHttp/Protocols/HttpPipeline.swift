///
/// Abstract HTTP request pipeline
///
/// A pipeline is a descriptor of a request -> response workflow.
/// It might includes validations date encoding, decoding
///
public protocol HttpPipeline {

    /// data type
    associatedtype DataType
    
    /// response type
    associatedtype ResponseType

    ///
    /// Executes the pipeline using an executor object
    ///
    /// The executor is usually a HttpClient task function, returning a response
    ///
    /// - Parameter executor: The  executor function to perform the HttpRequest
    ///
    /// - Throws: `HttpError` if something was wrong with the request
    ///
    /// - Returns: The generic Response object
    ///
    func execute(
        _ executor: ((HttpRawRequest<DataType>) async throws -> HttpRawResponse<DataType>)
    ) async throws -> ResponseType
}