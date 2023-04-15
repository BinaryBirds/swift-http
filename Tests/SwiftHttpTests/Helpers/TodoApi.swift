//
//  File.swift
//
//
//  Created by Tibor Bodecs on 2022. 03. 11..
//

import Foundation
import SwiftHttp

struct TodoApi: HttpCodablePipelineCollection {

    let client: HttpClient = UrlSessionHttpClient(logLevel: .trace)
    let apiBaseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

    func list() async throws -> [Todo] {
        try await decodableRequest(
            executor: client.dataTask,
            url: apiBaseUrl.path("todos"),
            method: .get
        )
    }
}
