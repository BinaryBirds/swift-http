//
//  UrlSessionHttpClient.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// Default URLSession based implementation of the HttpClient protocol
public struct UrlSessionHttpClient: HttpClient {
    
    let session: URLSession
    let log: Bool
    
    ///
    /// Initialize a new client object
    ///
    /// - Parameter session: The URLSession instance, default: `.shared`
    /// - Parameter log: Is logging enabled for the client
    ///
    public init(session: URLSession = .shared, log: Bool = false) {
        self.session = session
        self.log = log
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
    public func dataTask(_ req: HttpRequest) async throws -> HttpResponse {
        let urlRequest = req.urlRequest
        if log {
            print(urlRequest.curlString)
        }
			let res: (Data, URLResponse)
			
			if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
				res = try await session.data(for: urlRequest)
			} else {
				res = try await withCheckedThrowingContinuation { continuation in
					session.dataTask(with: urlRequest) { data, response, error in
						if let data = data, let response = response {
							continuation.resume(returning: (data, response))
						} else {
							continuation.resume(throwing: error ?? HttpError.invalidResponse)
						}
					}
					.resume()
				}
			}
			return try HttpRawResponse(res)
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
    public func uploadTask(_ req: HttpRequest) async throws -> HttpResponse {
        let urlRequest = req.urlRequest
        guard let data = urlRequest.httpBody else {
            throw HttpError.missingUploadData
        }
        if log {
            print(urlRequest.curlString)
        }
			let res: (Data, URLResponse)
			
			if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
				res = try await session.upload(for: urlRequest, from: data, delegate: nil)
			} else {
				res = try await withCheckedThrowingContinuation { continuation in
					session.uploadTask(with: urlRequest, from: data) { data, response, error in
						if let data = data, let response = response {
							continuation.resume(returning: (data, response))
						} else {
							continuation.resume(throwing: error ?? HttpError.invalidResponse)
						}
					}
					.resume()
				}
			}
        return try HttpRawResponse(res)
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
    public func downloadTask(_ req: HttpRequest) async throws -> HttpResponse {
        let urlRequest = req.urlRequest
        if log {
            print(urlRequest.curlString)
        }
			let res: (URL, URLResponse)
			
			if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
				res = try await session.download(for: urlRequest, delegate: nil)
			} else {
				res = try await withCheckedThrowingContinuation { continuation in
					session.downloadTask(with: urlRequest) { url, response, error in
						if let url = url, let response = response {
							continuation.resume(returning: (url, response))
						} else {
							continuation.resume(throwing: error ?? HttpError.invalidResponse)
						}
					}
					.resume()
				}
			}
        guard let pathData = res.0.path.data(using: .utf8) else {
            throw HttpError.invalidResponse
        }
        return try HttpRawResponse((pathData, res.1))
    }
}
