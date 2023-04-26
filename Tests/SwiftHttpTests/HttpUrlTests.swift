import XCTest
@testable import SwiftHttp

final class HttpUrlTests: XCTestCase {

    func testPaths() async throws {
        let baseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

        let url1 = baseUrl.appendPathComponents("todos", String(1))
        let expectation1 = "https://jsonplaceholder.typicode.com/todos/1"
        XCTAssertEqual(url1.absolute, expectation1)

        let url2 = baseUrl
            .appendPathComponents("todos")
            .appendQueryParameters(["foo": "1"])

        let expectation2 = "https://jsonplaceholder.typicode.com/todos?foo=1"
        XCTAssertEqual(url2.absolute, expectation2)
    }
}
