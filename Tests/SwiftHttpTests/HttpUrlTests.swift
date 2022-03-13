//
//  HttpUrlTests.swift
//  SwiftHttpTests
//
//  Created by Tibor Bodecs on 2022. 03. 13..
//

import XCTest
@testable import SwiftHttp

final class HttpUrlTests: XCTestCase {
        
    func testBaseUrl() async throws {
        let baseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")
        
        let todosUrl = baseUrl.path("todos")
        XCTAssertEqual(todosUrl.url.absoluteString, "https://jsonplaceholder.typicode.com/todos/")
        
        let todoUrl = baseUrl.path("todos", String(1))
        XCTAssertEqual(todoUrl.url.absoluteString, "https://jsonplaceholder.typicode.com/todos/1/")
        
        let query1Url = baseUrl.path("todos").query("foo", "bar")
        XCTAssertEqual(query1Url.url.absoluteString, "https://jsonplaceholder.typicode.com/todos/?foo=bar")
        
        let query2Url = baseUrl.path("todos").query([
            "foo": "baz",
            "bar": "1",
        ])
        XCTAssertEqual(query2Url.url.absoluteString, "https://jsonplaceholder.typicode.com/todos/?foo=baz&bar=1")
    }
}

