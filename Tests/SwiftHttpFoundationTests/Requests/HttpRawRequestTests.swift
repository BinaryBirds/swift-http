import XCTest
import SwiftHttp
@testable import SwiftHttpFoundation

final class HttpRawRequestTests: XCTestCase {

    func testRawRequest() async throws {
        let client = SwiftHttpFoundation()

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
