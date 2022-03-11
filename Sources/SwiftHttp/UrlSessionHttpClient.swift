//
//  UrlSessionHttpClient.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public struct UrlSessionHttpClient: HttpClient {
    
    let session: URLSession
    let log: Bool
    
    public init(session: URLSession = .shared, log: Bool = false) {
        self.session = session
        self.log = log
    }

    public func dataTask(_ req: HttpRequest) async throws -> HttpResponse {
        let urlRequest = req.urlRequest
        if log {
            print(urlRequest.curlString)
        }
        let res = try await session.data(for: urlRequest)
        return try HttpRawResponse(res)
    }
    
    public func uploadTask(_ req: HttpRequest) async throws -> HttpResponse {
        let urlRequest = req.urlRequest
        if log {
            print(urlRequest.curlString)
        }
        
        let res: (Data, URLResponse) = try await withUnsafeThrowingContinuation { c in
            session.uploadTask(with: urlRequest, from: urlRequest.httpBody) { data, response, error in
                if let error = error {
                    return c.resume(throwing: error)
                }
                guard let data = data, let urlResponse = response else {
                    return c.resume(throwing: HttpError.invalidResponse)
                }
                c.resume(returning: (data, urlResponse))
            }.resume()
        }
        return try HttpRawResponse(res)
    }
    
    /// returns the path data of the URL
    public func downloadTask(_ req: HttpRequest) async throws -> HttpResponse {
        let urlRequest = req.urlRequest
        if log {
            print(urlRequest.curlString)
        }

        let res: (Data, URLResponse) = try await withUnsafeThrowingContinuation { c in
            session.downloadTask(with: urlRequest) { url, response, error in
                if let error = error {
                    return c.resume(throwing: error)
                }
                guard let urlResponse = response, let url = url, let pathData = url.path.data(using: .utf8) else {
                    return c.resume(throwing: HttpError.invalidResponse)
                }
                c.resume(returning: (pathData, urlResponse))
            }
            .resume()
        }
        return try HttpRawResponse(res)
    }
}



