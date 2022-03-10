//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public protocol HttpClient {

    func dataTask(_ req: HttpRequest) async throws -> HttpResponse
    func downloadTask(_ req: HttpRequest) async throws -> HttpResponse
    func uploadTask(_ req: HttpRequest) async throws -> HttpResponse
}
