import XCTest
@testable import SwiftHttp
@testable import SwiftHttpFoundation

final class PostTests: XCTestCase {

    let api = PostApi()

    func testList() async throws {
        let posts = try await api.listPosts()
        XCTAssertEqual(posts.count, 100)
    }

    func testGet() async throws {
        let post = try await api.getPost(1)
        XCTAssertEqual(post.id, 1)
    }

    func testCreate() async throws {
        let object = Post(
            userId: 1,
            id: 1,
            title: "lorem ipsum",
            body: "dolor sit amet"
        )
        let post = try await api.createPost(object)
        XCTAssertEqual(post.id, 101)
    }

    func testUpdate() async throws {
        let object = Post.Update(
            userId: 1,
            title: "lorem ipsum",
            body: "dolor sit amet"
        )
        let post = try await api.updatePost(1, object)
        XCTAssertEqual(post.id, 1)
    }

    func testPatch() async throws {
        let object = Post.Update(
            userId: 1,
            title: "lorem ipsum",
            body: "dolor sit amet"
        )
        let post = try await api.patchPost(1, object)
        XCTAssertEqual(post.id, 1)
    }

    func testDelete() async throws {
        let res = try await api.deletePost(1)
        XCTAssertEqual(res.statusCode, .ok)
    }

}
