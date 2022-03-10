//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol HttpRequestPipeline {
    associatedtype Response

    func execute(_ executor: ((HttpRequest) async throws -> HttpResponse)) async throws -> Response
}
