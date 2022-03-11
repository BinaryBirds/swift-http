//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 11..
//

import Foundation
import SwiftHttp

struct FeatherError: Codable {
    let message: String
}

struct FeatherApi {

    let client = UrlSessionHttpClient(log: true)
    let apiBaseUrl = HttpUrl(scheme: "http", host: "test.binarybirds.com")
     
    func test() async throws -> [Post] {
        let pipeline = HttpDecodablePipeline<[Post]>(url: apiBaseUrl.path("api", "test"),
                                                     method: .get,
                                                     validators: [
                                                        HttpStatusCodeValidator(.ok)
                                                     ],
                                                     decoder: .json())
        return try await pipeline.execute(client.dataTask)
    }
    
    func testQueryParams() async throws -> String? {
        let pipeline = HttpRawPipeline(url: apiBaseUrl
                                            .path("api", "status")
                                            .query([
                                                "foo": "bar"
                                            ]),
                                        method: .get,
                                        validators: [
                                            HttpStatusCodeValidator(.ok)
                                        ])
        return try await pipeline.execute(client.dataTask).utf8String
    }
}
