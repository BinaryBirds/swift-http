import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post {
    struct Update: Codable {
        let userId: Int
        let title: String
        let body: String
    }
}
