import Foundation
import XCTest
import Vapor
import Authentication
@testable import Authorized

final class FutureTests: XCTestCase {
    
    static var allTests = [
        ("testAuthorize", testAuthorize),
    ]
    
    func testAuthorize() throws {
        let container = try self.container()
        let permissions = try container.make(PermissionManager.self)
        let request = Request(using: container)
        
        let user = SomeUser(id: 1)
        let otherUser = SomeUser(id: 2)
        let post = Post(id: 1, userId: user.id)
        
        permissions.allow(Post.self, .create, as: SomeUser.self)
        permissions.allow(Post.self, .modify, as: SomeUser.self) { post, user, container in
            return container.future(post.userId == user.id)
        }
        
        try request.authenticate(user)
        
        let postFuture = container.future(post)
        
        XCTAssertNoThrow(
            try postFuture.authorize(.create, as: user, on: container).wait()
        )
        
        XCTAssertThrowsError(
            try postFuture.authorize(.modify, as: otherUser, on: container).wait()
        )
        
        XCTAssertThrowsError(
            try postFuture.authorize(.modify, as: otherUser, on: container).wait()
        )
    }
    
}

fileprivate struct SomeUser: Authorizable, Authenticatable {
    
    let id: Int
    
}

fileprivate struct Post: Resource {
    
    enum Action: String, ResourceAction {
        case create
        case modify
    }
    
    let id: Int
    let userId: Int
    
}
