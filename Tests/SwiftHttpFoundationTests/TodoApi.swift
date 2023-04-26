import Foundation
import SwiftHttp
import SwiftHttpFoundation

struct TodoApi: HttpPipelineCollection  {

    typealias DataType = Data
    
    let client = SwiftHttpFoundation()
    let apiBaseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

    func list() async throws -> [Todo] {
        try await decodableRequest(
            url: apiBaseUrl.appendPathComponents("todos"),
            method: .get,
            decoder: .json(),
            executor: client.dataTask
        )
    }
}
