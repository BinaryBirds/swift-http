//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation
import SwiftHttp

struct PostsApi {

    let client = UrlSessionHttpClient(log: true)
    let apiBaseUrl = HttpUrl(domain: "jsonplaceholder.typicode.com")
    
    func listPosts() async throws -> [Post] {
        let pipeline = HttpJsonDecodablePipeline<[Post]>(url: apiBaseUrl.path("posts"), method: .get)
        return try await pipeline.execute(using: client)
    }
    
    func getPost(_ id: Int) async throws -> Post {
        let pipeline = HttpJsonDecodablePipeline<Post>(url: apiBaseUrl.path("posts", String(id)), method: .get)
        return try await pipeline.execute(using: client)
    }
    
    func createPost(_ post: Post) async throws -> Post {
        let pipeline = HttpJsonPipeline<Post, Post>(url: apiBaseUrl.path("posts"), method: .post, body: post)
        return try await pipeline.execute(using: client)
    }
    
    func updatePost(_ id: Int, _ post: Post.Update) async throws -> Post {
        let pipeline = HttpJsonPipeline<Post.Update, Post>(url: apiBaseUrl.path("posts", String(id)), method: .put, body: post)
        return try await pipeline.execute(using: client)
    }
    
    func patchPost(_ id: Int, _ post: Post.Update) async throws -> Post {
        let pipeline = HttpJsonPipeline<Post.Update, Post>(url: apiBaseUrl.path("posts", String(id)), method: .patch, body: post)
        return try await pipeline.execute(using: client)
    }

    func deletePost(_ id: Int) async throws -> HttpResponse {
        let pipeline = HttpDataPipeline(url: apiBaseUrl.path("posts", String(id)), method: .delete)
        return try await pipeline.execute(using: client)
    }
}
