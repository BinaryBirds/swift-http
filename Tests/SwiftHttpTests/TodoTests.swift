//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 11..
//

import XCTest
@testable import SwiftHttp

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
final class TodoTests: XCTestCase {
        
    let api = TodoApi()
    
    func testList() async throws {
        let todos = try await api.list()
        XCTAssertEqual(todos.count, 200)
    }
}

