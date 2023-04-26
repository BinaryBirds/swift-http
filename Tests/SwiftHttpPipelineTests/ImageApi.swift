import Foundation
import SwiftHttp
import SwiftHttpFoundation

struct ImageApi {

    let client = SwiftHttpFoundation()
    let apiBaseUrl = HttpUrl(host: "placekitten.com")

    func download() async throws -> Data {
        let pipeline = HttpRawPipeline<Data>(
            url: apiBaseUrl.appendPathComponents("150/150"),
            method: .get
        )
        let res = try await pipeline.execute(client.downloadTask)
        return res.data
    }
}
