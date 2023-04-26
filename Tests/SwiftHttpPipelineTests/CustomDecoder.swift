import Foundation
import SwiftHttp

extension HttpResponseDecoder {

    static func custom<U>(
        _ decoder: DataDecoder = CustomDataDecoder(),
        validators: [HttpResponseValidator] = [
            HttpHeaderValidator(.contentType) {
                $0.contains("application/json")
            }
        ]
    ) -> HttpResponseDecoder<U, DataDecoder> {
        .init(decoder: decoder, validators: validators)
    }
}

/// custom data decoder that transforms from a wrong object to a nice object...
struct CustomDataDecoder: HttpDataDecoder {
    struct WrongPost: Codable {
        let id: Int
    }

    func decode<T>(
        _ type: T.Type,
        from data: Data
    ) throws -> T where T: Decodable {
        let wrongPost = try JSONDecoder().decode(WrongPost.self, from: data)
        return Post(
            userId: 1,
            id: wrongPost.id,
            title: "lorem",
            body: "ipsum"
        ) as! T
    }
}
