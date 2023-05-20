//
//  HttpUrlTests.swift
//  SwiftHttpTests
//
//  Created by Tibor Bodecs on 2022. 03. 13..
//

import XCTest

@testable import SwiftHttp

final class HttpUrlTests: XCTestCase {

    func testPaths() async throws {
        let baseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

        let todoUrl = baseUrl.path("todos", String(1))
        XCTAssertEqual(
            todoUrl.url.absoluteString,
            "https://jsonplaceholder.typicode.com/todos/1/"
        )

        let query2Url = baseUrl.path("todos").query([
            "foo": "1"
        ])
        XCTAssertEqual(
            query2Url.url.absoluteString,
            "https://jsonplaceholder.typicode.com/todos/?foo=1"
        )
    }

    func testTrailingSlashEnabled() {
        let baseUrl = HttpUrl(
            host: "jsonplaceholder.typicode.com",
            trailingSlashEnabled: true
        )

        let todosUrl = baseUrl.path("todos")
        XCTAssertEqual(
            todosUrl.url.absoluteString,
            "https://jsonplaceholder.typicode.com/todos/"
        )

        let sitemapUrl = baseUrl.path("todos").resource("sitemap.xml")
        XCTAssertEqual(
            sitemapUrl.url.absoluteString,
            "https://jsonplaceholder.typicode.com/todos/sitemap.xml"
        )

        let query1Url = baseUrl.path("todos").query("foo", "bar")
        XCTAssertEqual(
            query1Url.url.absoluteString,
            "https://jsonplaceholder.typicode.com/todos/?foo=bar"
        )
    }

    func testTrailingSlashDisabled() {
        let baseUrl = HttpUrl(
            host: "jsonplaceholder.typicode.com",
            trailingSlashEnabled: false
        )

        let todosUrl = baseUrl.path("todos")
        XCTAssertEqual(
            todosUrl.url.absoluteString,
            "https://jsonplaceholder.typicode.com/todos"
        )

        let sitemapUrl = baseUrl.path("todos").resource("sitemap.xml")
        XCTAssertEqual(
            sitemapUrl.url.absoluteString,
            "https://jsonplaceholder.typicode.com/todos/sitemap.xml"
        )

        let query1Url = baseUrl.path("todos").query("foo", "bar")
        XCTAssertEqual(
            query1Url.url.absoluteString,
            "https://jsonplaceholder.typicode.com/todos?foo=bar"
        )
    }
    
    func testURLInitPathIssue() throws {
        let url = URL(string: "https://jsonplaceholder.typicode.com")!
        let baseUrl = try XCTUnwrap(HttpUrl(url: url))
        XCTAssertEqual(baseUrl.path, [])
    }
}
