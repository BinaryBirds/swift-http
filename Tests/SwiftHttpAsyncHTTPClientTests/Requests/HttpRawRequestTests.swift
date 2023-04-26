import XCTest
import Logging
import NIO
import SwiftHttp
import SwiftHttpAsyncHTTPClient

final class HttpRawRequestTests: XCTestCase {

    func testRawRequest() async throws {
        let logger = Logger(label: "async-http-client")
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let client = SwiftHttpAsyncClient(
            logger: logger,
            eventLoopGroupProvider: .shared(eventLoopGroup),
            configuration: .init()
        )

        let url = HttpUrl(
            host: "jsonplaceholder.typicode.com",
            path: "todos"
        )

        let req = HttpRequest(url: url)
        let response = try await client.dataTask(req)
        let todos = try JSONDecoder().decode([Todo].self, from: response.data)
        XCTAssertEqual(response.statusCode, .ok)
        XCTAssertEqual(todos.count, 200)
    }
}
