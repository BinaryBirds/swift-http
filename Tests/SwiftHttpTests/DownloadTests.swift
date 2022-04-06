//
//  File.swift
//  
//
//  Created by Viasz-Kádi Ferenc on 2022. 03. 27..
//

import Foundation

import XCTest
@testable import SwiftHttp

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
final class DownloadTests: XCTestCase {
        
    let api = ImageApi()
    
    func testDownload() async throws {
        let data = try await api.download()
        let filePath = String(data: data, encoding: .utf8)
        XCTAssertFalse(filePath == nil)
    }
}
