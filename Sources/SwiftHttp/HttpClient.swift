//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public protocol HttpClient {
    func request(_ req: HttpRequest) async throws -> HttpResponse

//    func download(_ req: HttpRequest) async throws -> HttpResponse
//    func upload(_ req: HttpRequest) async throws -> HttpResponse
}






