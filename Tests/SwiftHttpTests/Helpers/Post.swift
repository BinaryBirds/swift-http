//
//  Post.swift
//  SwiftHttpTests
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post {
    struct Update: Codable {
        let userId: Int
        let title: String
        let body: String
    }
}
