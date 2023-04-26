import XCTest
import Logging
import NIO
import SwiftHttp
@testable import SwiftHttpFoundation

final class HttpUrlFoundationTests: XCTestCase {

    func testFoundationUrl() async throws {
        let httpUrl = HttpUrl(
            host: "jsonplaceholder.typicode.com",
            path: "todos"
        )
        XCTAssertNotNil(httpUrl.foundationUrl)
        
        let url1 = httpUrl.foundationUrl!.absoluteString
        let expectation1 = "https://jsonplaceholder.typicode.com/todos"
        XCTAssertEqual(url1, expectation1)
    }
    
    func testFoundationUrlWithSlashes() async throws {
        let httpUrl = HttpUrl(
            host: "jsonplaceholder.typicode.com",
            path: "/todos/"
        )
        XCTAssertNotNil(httpUrl.foundationUrl)
        
        let url1 = httpUrl.foundationUrl!.absoluteString
        let expectation1 = "https://jsonplaceholder.typicode.com/todos/"
        XCTAssertEqual(url1, expectation1)
    }
}
