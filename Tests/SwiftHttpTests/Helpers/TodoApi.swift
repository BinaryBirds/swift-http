//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 11..
//

import Foundation
import SwiftHttp

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
struct TodoApi: HttpCodablePipelineCollection {

    let client: HttpClient = UrlSessionHttpClient(log: true)
    let apiBaseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

    
    func list() async throws -> [Todo] {
        try await decodableRequest(executor: client.dataTask,
                                   url: apiBaseUrl.path("todos"),
                                   method: .get)
    }    
}
