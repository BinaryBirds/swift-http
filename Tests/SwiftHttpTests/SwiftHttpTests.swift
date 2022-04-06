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

        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(10)) {
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
        let api = FeatherApi()
        do {
            _ = try await api.test()
        }
        catch HttpError.invalidStatusCode(let res) {
            let decoder = HttpResponseDecoder<FeatherError>(decoder: JSONDecoder())
            do {
                let error = try decoder.decode(res.data)
                print(res.statusCode, error)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func testQueryParams() async throws {
        let api = FeatherApi()
        let res = try await api.testQueryParams()
        XCTAssertEqual(res, "ok")
    }
}

