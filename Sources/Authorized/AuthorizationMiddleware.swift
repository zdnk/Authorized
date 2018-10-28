import Vapor
import Authentication

public struct AuthorizationMiddleware<A: Authorizable & Authenticatable, R: Resource>: Middleware {
    
    public let action: R.Action
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        try request.authorize(A.self, R.self, action)
        return try next.respond(to: request)
    }
    
}
