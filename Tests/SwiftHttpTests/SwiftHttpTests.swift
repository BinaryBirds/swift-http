//
//  SwiftHttpTests.swift
//  SwiftHttpTests
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import XCTest
@testable import SwiftHttp

final class SwiftHttpTests: XCTestCase {
        
    func testCancellation() async throws {
        let task = Task {
            let api = PostApi()
            _ = try await api.listPosts()
            XCTFail("Request should be cancelled")
        }

        let deadline = DispatchTime.now() + .milliseconds(10)
        DispatchQueue.global().asyncAfter(deadline: deadline) {
            task.cancel()
        }

        do {
            let _ = try await task.value
        }
        catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .cancelled)
        }
    }
    
    func testError() async throws {
        let api = PostApi()
        do {
            _ = try await api.invalidApiCall()
        }
        catch HttpError.invalidStatusCode(let res) {
            XCTAssertEqual(res.statusCode, .notFound)
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testQueryParams() async throws {
        let api = PostApi()
        let res = try await api.filterPosts(1)
        XCTAssertEqual(res.count, 10)
    }
}
