//
//  File.swift
//
//
//  Created by Tibor Bodecs on 2022. 03. 11..
//

import Foundation
import SwiftHttp
@testable import SwiftHttpFoundation

struct TodoApi: HttpPipelineCollection  {

    typealias DataType = Data
    
    let client = UrlSessionHttpClient(logLevel: .trace)
    let apiBaseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

    func list() async throws -> [Todo] {
        try await decodableRequest(
            url: apiBaseUrl.path("todos"),
            method: .get,
            decoder: .json(),
            executor: client.dataTask
        )
    }
}
