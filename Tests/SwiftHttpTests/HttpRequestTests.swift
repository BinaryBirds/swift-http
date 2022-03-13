//
//  HttpRequestTests.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 13..
//

import XCTest
@testable import SwiftHttp

final class HttpRequestTests: XCTestCase {
        
    func testRequests() async throws {
        let url = HttpUrl(host: "localhost", path: ["login"])
        
        let token: String = "valid-token"
        let body = try JSONEncoder().encode([
            "foo": "bar",
        ])
        let req = HttpRawRequest(url: url,
                                 method: .post,
                                 headers: [
                                    .key(.authorization): "Bearer \(token)",
                                 ],
                                 body: body)
        
        let expectation = """
            curl "https://localhost/login/" \\
            \t-X POST \\
            \t-H 'Authorization: Bearer valid-token' \\
            \t-d '{"foo":"bar"}'
            """
        
        XCTAssertEqual(req.urlRequest.curlString, expectation)
    }
}

