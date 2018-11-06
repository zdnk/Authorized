import Vapor
import Authentication

public struct AuthorizationMiddleware<A: Authorizable & Authenticatable, R: Resource>: Middleware {
    
    public let action: R.Action
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        return try request.authorize(A.self, R.self, action)
            .flatMap { _ in
                return try next.respond(to: request)
            }
    }
    
}
