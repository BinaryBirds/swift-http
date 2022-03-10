//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation
import SwiftHttp

struct UrlSessionHttpClient: HttpClient {
    
    var log: Bool

    func request(_ req: HttpRequest) async throws -> HttpResponse {
        let urlRequest = req.urlRequest
        if log {
            print(urlRequest.curlString)
        }
        let res = try await URLSession.shared.data(for: urlRequest, delegate: nil)
        return try HttpDataResponse(res)
    }
}

