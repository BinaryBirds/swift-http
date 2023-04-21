/// Abstract HttpClient protocol
///
/// A HTTP client should be able to perfrom 3 main tasks using a HttpRequest and return a HttpResponse
///
/// - data task
/// - download task
/// - upload task
///
public protocol HttpClient {
    
    associatedtype DataType

    ///
    /// Retrieves the contents of the request (in memory)
    ///
    /// - Parameter req: The  HttpRequest to perfrom
    ///
    /// - Throws: `HttpError` if something was wrong with the request
    ///
    /// - Returns: A HttpResponse object
    ///
    func dataTask(
        _ req: HttpRawRequest<DataType>
    ) async throws -> HttpRawResponse<DataType>

    ///
    /// Retreives the contetns of the request (to a file), then returns the location (URL) of the file as a response data object
    ///
    /// - Parameter req: The  HttpRequest to perfrom
    ///
    /// - Throws: `HttpError` if something was wrong with the request
    ///
    /// - Returns: A HttpResponse object
    ///
    func downloadTask(
        _ req: HttpRawRequest<DataType>
    ) async throws -> HttpRawResponse<DataType>

    ///
    /// Performs a HTTP request and uploads the body as binary data to the server
    ///
    /// - Parameter req: The  HttpRequest to perfrom
    ///
    /// - Throws: `HttpError` if something was wrong with the request
    ///
    /// - Returns: A HttpResponse object
    ///
    func uploadTask(
        _ req: HttpRawRequest<DataType>
    ) async throws -> HttpRawResponse<DataType>
}


