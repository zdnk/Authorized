import Vapor
import Authentication

extension Request {
    
    public func authorize<A, R>(_: A.Type, _ resource: R, _ action: R.Action) throws where A: Authorizable & Authenticatable, R: Resource {
        let user = try self.requireAuthenticated(A.self)
        let permissions = try self.make(PermissionManager.self)
        
        guard permissions.allowed(resource, action, as: user) else {
            throw Abort(.forbidden)
        }
    }
    
    public func authorize<A, R>(_ user: A, _ resource: R, _ action: R.Action) throws where A: Authorizable, R: Resource {
        let permissions = try self.make(PermissionManager.self)
        
        guard permissions.allowed(resource, action, as: user) else {
            throw Abort(.forbidden)
        }
    }
    
    public func authorize<A, R>(_: A.Type, _ resource: R.Type, _ action: R.Action) throws where A: Authorizable & Authenticatable, R: Resource {
        let user = try self.requireAuthenticated(A.self)
        let permissions = try self.make(PermissionManager.self)
        
        guard permissions.allowed(resource, action, as: user) else {
            throw Abort(.forbidden)
        }
    }
    
    public func authorize<A, R>(_ user: A, _ resource: R.Type, _ action: R.Action) throws where A: Authorizable, R: Resource {
        let permissions = try self.make(PermissionManager.self)
        
        guard permissions.allowed(resource, action, as: user) else {
            throw Abort(.forbidden)
        }
    }
    
}
