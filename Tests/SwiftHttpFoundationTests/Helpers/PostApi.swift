//
//  PostsApi.swift
//  SwiftHttpTests
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation
import SwiftHttp
import SwiftHttpFoundation

struct PostApi: HttpPipelineCollection {

    typealias DataType = Data
    
    let client = UrlSessionHttpClient(logLevel: .trace)
    let apiBaseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

    /// NOTE: this API call should return a 404 response
    func invalidApiCall() async throws -> [Post] {
        try await decodableRequest(
            url: apiBaseUrl.path("invalid-posts"),
            method: .get,
            decoder: .json(),
            executor: client.dataTask
        )
    }

    func listPosts() async throws -> [Post] {
        try await decodableRequest(
            url: apiBaseUrl.path("posts"),
            method: .get,
            decoder: .json(),
            executor: client.dataTask
        )
    }

    func filterPosts(_ userId: Int) async throws -> [Post] {
        try await decodableRequest(
            url:
                apiBaseUrl
                .path("posts")
                .query([
                    "userId": String(userId)
                ]),
            method: .get,
            decoder: .json(),
            executor: client.dataTask
        )
    }

    func getPost(_ id: Int) async throws -> Post {
        try await decodableRequest(
            url: apiBaseUrl.path("posts", String(id)),
            method: .get,
            decoder: .json(),
            executor: client.dataTask
        )
    }

    func createPost(_ post: Post) async throws -> Post {
        try await codableRequest(
            url: apiBaseUrl.path("posts"),
            method: .post,
            body: post,
            encoder: .json(),
            decoder: .json(),
            executor: client.dataTask
        )
    }

    func updatePost(_ id: Int, _ post: Post.Update) async throws -> Post {
        try await codableRequest(
            url: apiBaseUrl.path("posts", String(id)),
            method: .put,
            body: post,
            encoder: .json(),
            decoder: .json(),
            executor: client.dataTask
        )
    }

    func patchPost(_ id: Int, _ post: Post.Update) async throws -> Post {
        try await codableRequest(
            url: apiBaseUrl.path("posts", String(id)),
            method: .put,
            body: post,
            encoder: .json(),
            decoder: .json(),
            executor: client.dataTask
        )
    }

    func deletePost(_ id: Int) async throws -> HttpRawResponse<DataType> {
        try await rawRequest(
            url: apiBaseUrl.path("posts", String(id)),
            method: .delete,
            executor: client.dataTask
        )
    }
}
