//
//  HttpValidationTests.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 13..
//

import XCTest

@testable import SwiftHttp

//final class HttpValidationTests: XCTestCase {
//
//    func testStatusCodeValidator() async throws {
//        let response = HttpRawResponse(
//            statusCode: .ok,
//            headers: [:],
//            data: .init()
//        )
//        let validator1 = HttpStatusCodeValidator()  // 200...299
//        try validator1.validate(response)
//
//        let validator2 = HttpStatusCodeValidator(.ok)  // 200
//        try validator2.validate(response)
//    }
//
//    func testBadStatusCodeValidator() async throws {
//        let response = HttpRawResponse(
//            statusCode: .notFound,
//            headers: [:],
//            data: .init()
//        )
//        let validator = HttpStatusCodeValidator()  // 200...299
//        do {
//            try validator.validate(response)
//            XCTFail("Bad validation result")
//        }
//        catch {
//
//        }
//    }
//
//    func testBadStatusCodeValidator2() async throws {
//        let response = HttpRawResponse(
//            statusCode: .notFound,
//            headers: [:],
//            data: .init()
//        )
//        let validator = HttpStatusCodeValidator(.ok)
//        do {
//            try validator.validate(response)
//            XCTFail("Bad validation result")
//        }
//        catch {
//
//        }
//    }
//
//    func testHeaderValidator() async throws {
//        let response = HttpRawResponse(
//            statusCode: .ok,
//            headers: [
//                .contentType: "application/json"
//            ],
//            data: .init()
//        )
//        let validator = HttpHeaderValidator(.contentType) { value in
//            value == "application/json"
//        }
//        try validator.validate(response)
//    }
//
//    func testInvalidHeaderValidator() async throws {
//        let response = HttpRawResponse(
//            statusCode: .ok,
//            headers: [
//                .contentType: "application/json"
//            ],
//            data: .init()
//        )
//        let validator = HttpHeaderValidator(.contentType) { value in
//            value == "application/xml"
//        }
//        do {
//            try validator.validate(response)
//            XCTFail("Bad validation result")
//        }
//        catch {
//
//        }
//    }
//
//    func testMultipleValidation() async throws {
//        let response = HttpRawResponse(
//            statusCode: .ok,
//            headers: [
//                .contentType: "application/json"
//            ],
//            data: .init()
//        )
//
//        let validator1 = HttpStatusCodeValidator(.ok)
//        let validator2 = HttpHeaderValidator(.contentType) { value in
//            value == "application/json"
//        }
//        let validation = HttpResponseValidation([validator1, validator2])
//        try validation.validate(response)
//    }
//}
