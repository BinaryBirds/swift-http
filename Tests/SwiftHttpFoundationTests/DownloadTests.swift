import Foundation
import XCTest

@testable import SwiftHttp

final class DownloadTests: XCTestCase {

    let api = ImageApi()

    func testDownload() async throws {
        let data = try await api.download()
        let filePath = String(data: data, encoding: .utf8)
        XCTAssertFalse(filePath == nil)
    }
}
