import Foundation
import SwiftHttp
import SwiftHttpFoundation

struct TodoApi: HttpPipelineCollection  {

    typealias DataType = Data
    
    let client = SwiftHttpFoundationClient(logLevel: .trace)
    let apiBaseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

    func list() async throws -> [Todo] {
        try await decodableRequest(
            url: apiBaseUrl.path("todos"),
            method: .get,
            decoder: .json(),
            executor: client.dataTask
        )
    }
}
