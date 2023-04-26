import Foundation
import NIOCore
import AsyncHTTPClient

struct Test {
    
//    func session() async throws {
//        let (bytes, response) = try await URLSession.shared.bytes(
//            for: .init(url: .init(fileURLWithPath: ""))
//        )
//
//        for try await line in bytes.lines {
//
//        }
//    }
    
    func downloadStream() async throws {
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        do {
            var request = HTTPClientRequest(url: "https://apple.com/")
            request.method = .POST
            request.headers.add(name: "User-Agent", value: "Swift HTTPClient")
            request.body = .bytes(ByteBuffer(string: "some data"))
            
            let response = try await httpClient.execute(request, timeout: .seconds(30))

            // if defined, the content-length headers announces the size of the body
            let expectedBytes = response.headers.first(name: "content-length").flatMap(Int.init)

            var receivedBytes = 0
            // asynchronously iterates over all body fragments
            // this loop will automatically propagate backpressure correctly
            for try await buffer in response.body {
                // for this example, we are just interested in the size of the fragment
                receivedBytes += buffer.readableBytes

                if let expectedBytes = expectedBytes {
                    // if the body size is known, we calculate a progress indicator
                    let progress = Double(receivedBytes) / Double(expectedBytes)
                    print("progress: \(Int(progress * 100))%")
                }
            }
            print("did receive \(receivedBytes) bytes")
        } catch {
            print("request failed:", error)
        }
        // it is important to shutdown the httpClient after all requests are done, even if one failed
        try await httpClient.shutdown()
    }

    func uploadStream() async throws {
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)

        var request = HTTPClientRequest(url: "https://localhost:8008/")


        let counter = Counter(limit: 10)
        request.body = .stream(counter, length: .unknown)
        let response = try await httpClient.execute(request, timeout: .seconds(30))
        let expectedBytes = response.headers.first(name: "content-length").flatMap(Int.init)

        var receivedBytes = 0
        // asynchronously iterates over all body fragments
        // this loop will automatically propagate backpressure correctly
        for try await buffer in response.body {
            // for this example, we are just interested in the size of the fragment
            receivedBytes += buffer.readableBytes

            if let expectedBytes = expectedBytes {
                // if the body size is known, we calculate a progress indicator
                let progress = Double(receivedBytes) / Double(expectedBytes)
                print("progress: \(Int(progress * 100))%")
            }
        }
        print("did receive \(receivedBytes) bytes")

        // it is important to shutdown the httpClient after all requests are done, even if one failed
        try await httpClient.shutdown()
    }
}

