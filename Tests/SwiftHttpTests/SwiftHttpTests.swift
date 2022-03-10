import XCTest
@testable import SwiftHttp

final class SwiftHttpTests: XCTestCase {
        
    func testCancellation() async throws {
        let task = Task {
            let api = PostsApi()
            _ = try await api.listPosts()
            XCTFail("Request should be cancelled")
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(10)) {
            task.cancel()
        }

        do {
            let _ = try await task.value
        }
        catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .cancelled)
        }
    }
    
    // MARK: - api tests
    
    func testList() async throws {
        let api = PostsApi()
        let posts = try await api.listPosts()
        XCTAssertEqual(posts.count, 100)
    }
    
    func testGet() async throws {
        let api = PostsApi()
        let post = try await api.getPost(1)
        XCTAssertEqual(post.id, 1)
    }
    
    func testCreate() async throws {
        let api = PostsApi()
        let object = Post(userId: 1, id: 1, title: "lorem ipsum", body: "dolor sit amet")
        let post = try await api.createPost(object)
        XCTAssertEqual(post.id, 101)
    }
    
    func testUpdate() async throws {
        let api = PostsApi()
        let object = Post.Update(userId: 1, title: "lorem ipsum", body: "dolor sit amet")
        let post = try await api.updatePost(1, object)
        XCTAssertEqual(post.id, 1)
    }
    
    func testPatch() async throws {
        let api = PostsApi()
        let object = Post.Update(userId: 1, title: "lorem ipsum", body: "dolor sit amet")
        let post = try await api.patchPost(1, object)
        XCTAssertEqual(post.id, 1)
    }
    
    func testDelete() async throws {
        let api = PostsApi()
        let res = try await api.deletePost(1)
        XCTAssertEqual(res.statusCode, .ok)
    }
}
