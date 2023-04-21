//
//  File.swift
//
//
//  Created by Tibor Bodecs on 2022. 03. 11..
//

import XCTest

@testable import SwiftHttp

final class TodoTests: XCTestCase {

    let api = TodoApi()

    func testList() async throws {
        let todos = try await api.list()
        XCTAssertEqual(todos.count, 200)
    }
}
