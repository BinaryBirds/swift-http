//
//  UrlSessionHttpClient.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation
import Logging
import SwiftHttp

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Default URLSession based implementation of the HttpClient protocol
public struct SwiftHttpFoundation: HttpExecutorInterface {
    public typealias DataType = Data

    let session: URLSession
    let logger: Logger?

    ///
    /// Initializes an instance of `HTTPClient` with the given session and logging level.
    ///
    /// - Parameter session: The `URLSession` instance to be used for network requests. Defaults to `.shared`.
    /// - Parameter logLevel: The `Logger.Level` to be used for logging. Defaults to `.critical`.
    ///
    /// - Returns: An instance of `HTTPClient`.
    ///
    public init(
        session: URLSession = .shared,
        logger: Logger? = nil
    ) {
        self.session = session
        self.logger = logger
    }

    ///
    /// Performs a data task (in memory) HTTP request
    ///
    /// - Parameter req: The request object
    ///
    /// - Throws: `HttpError` if something was wrong with the request
    ///
    /// - Returns: The entire HTTP response
    ///
    public func dataTask(
        _ req: HttpRawRequest<DataType>
    ) async throws -> HttpRawResponse<DataType> {
        guard let urlRequest = req.foundationRequest else {
            throw HttpError.invalidResponse
        }
        logger?.info(.init(stringLiteral: req.cURL))
        let res: (Data, URLResponse)

        #if os(Linux)
            res = try await asyncMethod(with: urlRequest, session.dataTask)
        #else
            if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
                res = try await session.data(for: urlRequest)
            }
            else {
                res = try await asyncMethod(with: urlRequest, session.dataTask)
            }
        #endif

        do {
            let rawResponse = try HttpRawResponse(res)
//            logger?.trace(.init(stringLiteral: rawResponse.traceLogValue))
//            logger?.debug(.init(stringLiteral: res.logValue))
            return rawResponse
        }
        catch {
//            logger?.debug(.init(stringLiteral: res.logValue))
            throw error
        }
    }

    ///
    /// Uploads the contents of the request and returns the response
    ///
    /// - Parameter req: The request object
    ///
    /// - Throws: `HttpError` if something was wrong with the request
    ///
    /// - Returns: The entire HTTP response
    ///
    public func uploadTask(
        _ req: HttpRawRequest<DataType>
    ) async throws -> HttpRawResponse<DataType> {
        guard let urlRequest = req.foundationRequest else {
            throw HttpError.invalidRequest
        }
        guard let data = urlRequest.httpBody else {
            throw HttpError.missingUploadData
        }
        logger?.info(.init(stringLiteral: req.cURL))
        let res: (Data, URLResponse)

        #if os(Linux)
            res = try await asyncMethod(with: urlRequest) {
                session.uploadTask(with: $0, from: data, completionHandler: $1)
            }
        #else
            if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
                res = try await session.upload(
                    for: urlRequest,
                    from: data,
                    delegate: nil
                )
            }
            else {
                res = try await asyncMethod(with: urlRequest) {
                    session.uploadTask(
                        with: $0,
                        from: data,
                        completionHandler: $1
                    )
                }
            }
        #endif

        do {
            let rawResponse = try HttpRawResponse(res)
//            logger?.trace(.init(stringLiteral: rawResponse.traceLogValue))
//            logger?.debug(.init(stringLiteral: res.0.logValue))
            return rawResponse
        }
        catch {
//            logger?.debug(.init(stringLiteral: res.0.logValue))
            throw error
        }
    }

    ///
    /// Downloads the contents of the request and returns the response
    ///
    /// - Parameter req: The request object
    ///
    /// - Throws: `HttpError` if something was wrong with the request
    ///
    /// - Returns: The entire response, setting the file location url as an encoded utf8 string as the response data
    ///
    public func downloadTask(
        _ req: HttpRawRequest<DataType>
    ) async throws -> HttpRawResponse<DataType> {
        guard let urlRequest = req.foundationRequest else {
            throw HttpError.invalidRequest
        }
        logger?.info(.init(stringLiteral: req.cURL))
        let res: (URL, URLResponse)
        #if os(Linux)
            res = try await asyncMethod(with: urlRequest, session.downloadTask)
        #else
            if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
                res = try await session.download(for: urlRequest, delegate: nil)
            }
            else {
                res = try await asyncMethod(
                    with: urlRequest,
                    session.downloadTask
                )
            }
        #endif

        guard let pathData = res.0.path.data(using: .utf8) else {
            throw HttpError.invalidResponse
        }

        do {
            let rawResponse = try HttpRawResponse((pathData, res.1))
//            logger?.trace(.init(stringLiteral: rawResponse.traceLogValue))
//            logger?.debug(.init(stringLiteral: res.0.absoluteString))
            return rawResponse
        }
        catch {
//            logger?.debug(.init(stringLiteral: res.0.absoluteString))
            throw error
        }
    }

    private func asyncMethod<T, S: URLSessionTask>(
        with urlRequest: URLRequest,
        _ method: @escaping (
            URLRequest, @escaping @Sendable (T?, URLResponse?, Error?) -> Void
        ) -> S
    ) async throws -> (T, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            method(urlRequest) { t, response, error in
                if let t = t, let response = response {
                    continuation.resume(returning: (t, response))
                }
                else {
                    continuation.resume(
                        throwing: error ?? HttpError.invalidResponse
                    )
                }
            }
            .resume()
        }
    }
}
