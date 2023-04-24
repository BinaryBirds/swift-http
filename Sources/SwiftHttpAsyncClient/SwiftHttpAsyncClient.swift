import AsyncHTTPClient
import NIOCore
import SwiftHttp
import Logging

/// Default URLSession based implementation of the HttpClient protocol
public struct SwiftHttpAsyncClient: HttpClient {
    public typealias DataType = ByteBuffer
    
    private let loggerLabel = "com.binarybirds.swift-http-async"
    
    let logger: Logger
    let eventLoopGroupProvider: HTTPClient.EventLoopGroupProvider
    let configuration: HTTPClient.Configuration
    
    init(
        logger: Logger,
        eventLoopGroupProvider: HTTPClient.EventLoopGroupProvider = .createNew,
        configuration: HTTPClient.Configuration = .init()
    ) {
        self.logger = logger
        self.eventLoopGroupProvider = eventLoopGroupProvider
        self.configuration = configuration
    }
    
    public func dataTask(
        _ req: HttpRawRequest<ByteBuffer>
    ) async throws -> HttpRawResponse<ByteBuffer> {
        let httpClient = HTTPClient(eventLoopGroupProvider: eventLoopGroupProvider)
        do {
            
            var request = HTTPClientRequest(url: "https://apple.com/")
            request.method = req.method.asyncHttpMethod
            for header in req.headers {
                request.headers.add(
                    name: header.key.rawValue,
                    value: header.value
                )
            }
            if let body = req.body {
                request.body = .bytes(body)
            }
            
            let res = try await httpClient.execute(request, timeout: .seconds(30))

            let expectedBytes = res.headers.first(
                name: "content-length"
            ).flatMap(Int.init)

            var receivedBytes = 0
            var buffer = ByteBuffer()
            for try await chunk in res.body {
                var chunk = chunk
                receivedBytes += chunk.readableBytes

                if let expectedBytes = expectedBytes {
                    let progress = Double(receivedBytes) / Double(expectedBytes)
                    print("progress: \(Int(progress * 100))%")
                }
                buffer.writeBuffer(&chunk)
            }
            
            var headers: [HttpHeaderKey: String] = [:]
            for header in res.headers {
                headers[.init(header.name)] = header.value
            }
            
            try await httpClient.shutdown()
            return HttpRawResponse<ByteBuffer>.init(
                statusCode: res.status.httpStatus,
                headers: headers,
                data: buffer
            )
        }
        catch {
            try await httpClient.shutdown()
            throw error
        }
    }
    
    public func downloadTask(
        _ req: HttpRawRequest<ByteBuffer>
    ) async throws -> HttpRawResponse<ByteBuffer> {
        try await dataTask(req)
    }
    
    public func uploadTask(
        _ req: HttpRawRequest<ByteBuffer>
    ) async throws -> HttpRawResponse<ByteBuffer> {
        try await dataTask(req)
    }
    
}
