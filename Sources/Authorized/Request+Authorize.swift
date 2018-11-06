import Vapor
import Authentication

extension Request {
    
    public func authorize<A, R>(_: A.Type, _ resource: R, _ action: R.Action) throws -> Future<R> where A: Authorizable & Authenticatable, R: Resource {
        let user = try self.requireAuthenticated(A.self)
        let permissions = try self.make(PermissionVerifying.self)
        
        return permissions.authorize(resource, action, as: user, on: self)
    }
    
    public func authorize<A, R>(_ user: A, _ resource: R, _ action: R.Action) throws -> Future<R> where A: Authorizable, R: Resource {
        let permissions = try self.make(PermissionVerifying.self)
        
        return permissions.authorize(resource, action, as: user, on: self)
    }
    
    public func authorize<A, R>(_: A.Type, _ resource: R.Type, _ action: R.Action) throws -> Future<Void> where A: Authorizable & Authenticatable, R: Resource {
        let user = try self.requireAuthenticated(A.self)
        let permissions = try self.make(PermissionVerifying.self)
        
        return permissions.authorize(resource, action, as: user, on: self)
    }
    
    public func authorize<A, R>(_ user: A, _ resource: R.Type, _ action: R.Action) throws -> Future<Void> where A: Authorizable, R: Resource {
        let permissions = try self.make(PermissionVerifying.self)
        
        return permissions.authorize(resource, action, as: user, on: self)
    }
    
}
