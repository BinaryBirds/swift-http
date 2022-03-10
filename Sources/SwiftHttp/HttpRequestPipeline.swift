//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol HttpRequestPipeline {
    associatedtype Response

    func execute(using client: HttpClient) async throws -> Response
}
