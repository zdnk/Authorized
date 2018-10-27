import Foundation
import XCTest
import Vapor
import Authentication
@testable import Authorization

final class PermissionsTests: XCTestCase {
    
    static var allTests = [
        ("testAllowed", testAllowed),
        ("testAuthorize", testAuthorize),
    ]
    
    func testAllowed() {
        let permissions = Permissions()
        let user = SomeUser(id: 1)
        let otherUser = SomeUser(id: 2)
        let post = Post(id: 1, userId: user.id)
        
        permissions.allow(Post.self, .create, for: SomeUser.self)
        permissions.allow(Post.self, .modify, for: SomeUser.self) { post, user in
            return post.userId == user.id
        }
        
        XCTAssertTrue(permissions.allowed(Post.self, .create, as: user))
        XCTAssertTrue(permissions.allowed(post, .create, as: user))
        
        XCTAssertTrue(permissions.allowed(Post.self, .create, as: otherUser))
        XCTAssertTrue(permissions.allowed(post, .create, as: otherUser))
        
        XCTAssertFalse(permissions.allowed(Post.self, .modify, as: user))
        XCTAssertTrue(permissions.allowed(post, .modify, as: user))
        
        XCTAssertFalse(permissions.allowed(Post.self, .modify, as: otherUser))
        XCTAssertFalse(permissions.allowed(post, .modify, as: otherUser))
    }
    
    func testAuthorize() throws {
        let container = try self.container()
        let permissions = try container.make(Permissions.self)
        let request = Request(using: container)
        
        let user = SomeUser(id: 1)
        let otherUser = SomeUser(id: 2)
        let post = Post(id: 1, userId: user.id)
        
        permissions.allow(Post.self, .create, for: SomeUser.self)
        permissions.allow(Post.self, .modify, for: SomeUser.self) { post, user in
            return post.userId == user.id
        }
        
        try request.authenticate(user)
        
        XCTAssertNoThrow(
            try request.authorize(SomeUser.self, Post.self, .create)
        )
        
        XCTAssertNoThrow(
            try request.authorize(SomeUser.self, post, .create)
        )
        
        XCTAssertThrowsError(
            try request.authorize(SomeUser.self, Post.self, .modify)
        )
        
        XCTAssertThrowsError(
            try request.authorize(otherUser, Post.self, .modify)
        )
        
        XCTAssertThrowsError(
            try request.authorize(otherUser, post, .modify)
        )
        
        XCTAssertNoThrow(
            try request.authorize(SomeUser.self, post, .modify)
        )
        
    }
    
    private func container() throws -> Container {
        var services = Services.default()
        services.register(Permissions())
        try services.register(AuthenticationProvider())
        let worker = EmbeddedEventLoop()
        
        return BasicContainer(
            config: Config.default(),
            environment: .testing,
            services: services,
            on: worker
        )
    }
    
}

fileprivate struct SomeUser: Authorizable, Authenticatable {
    
    let id: Int
    
}

fileprivate struct Post: Protected {
    
    enum Action: String, ProtectedAction {
        case create
        case modify
    }
    
    let id: Int
    let userId: Int
    
}
