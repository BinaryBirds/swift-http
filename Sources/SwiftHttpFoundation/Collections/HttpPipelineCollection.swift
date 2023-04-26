import Foundation
import SwiftHttp

extension HttpPipelineCollection where DataType == Data {

    func decodableJsonRequest<U: Decodable>(
        url: HttpUrl,
        method: HttpMethod,
        headers: [HttpHeaderKey: String],
        body: DataType?,
        validators: [HttpResponseValidator],
        decoder: JSONDecoder = .init(),
        executor: HttpExecutorBlock<DataType>
    ) async throws -> U {
    
        try await decodableRequest(
            url: url,
            method: method,
            headers: headers,
            body: body,
            decoder: .json(decoder),
            executor: executor
        )
    }
}
