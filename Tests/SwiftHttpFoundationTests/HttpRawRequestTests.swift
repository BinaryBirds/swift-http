import XCTest
import SwiftHttp
@testable import SwiftHttpFoundation

final class HttpRawRequestTests: XCTestCase {

    func testRawRequest() async throws {
        let client = SwiftHttpFoundationClient(session: .shared, logLevel: .trace)

        let url = HttpUrl(
            scheme: "https",
            host: "jsonplaceholder.typicode.com",
            port: 80,
            path: ["todos"],
            resource: nil,
            query: [:],
            fragment: nil
        )

        let req = HttpDataRequest(
            url: url,
            method: .get,
            headers: [:],
            body: nil
        )

        let response = try await client.dataTask(req)
        let todos = try JSONDecoder().decode([Todo].self, from: response.data)
        XCTAssertEqual(response.statusCode, .ok)
        XCTAssertEqual(todos.count, 200)
    }
}
