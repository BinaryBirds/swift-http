//
//  HttpRawRequestTests.swift
//  SwiftHttpTests
//
//  Created by Tibor Bodecs on 2022. 03. 13..
//

import XCTest
@testable import SwiftHttp

final class HttpRawRequestTests: XCTestCase {
        
    func testRawRequest() async throws {
        let client = UrlSessionHttpClient(session: .shared, log: true)
        
        let url = HttpUrl(scheme: "https",
                          host: "jsonplaceholder.typicode.com",
                          port: 80,
                          path: ["todos"],
                          resource: nil,
                          query: [:],
                          fragment: nil)
        
        let req = HttpRawRequest(url: url, method: .get, headers: [:], body: nil)
        
        let response = try await client.dataTask(req)
        let todos = try JSONDecoder().decode([Todo].self, from: response.data)
        XCTAssertEqual(response.statusCode, .ok)
        XCTAssertEqual(todos.count, 200)
    }
}

