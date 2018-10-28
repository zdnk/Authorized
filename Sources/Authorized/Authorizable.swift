import Vapor

public protocol Authorizable {
    
    static var authorizableIdentifier: String { get }
    
}

extension Authorizable {
    
    public static var authorizableIdentifier: String {
        return String(describing: Self.self)
    }
    
    func can<R>(_: R.Type, _ action: R.Action, on container: Container) throws -> Bool where R: Resource {
        let permissions = try container.make(PermissionManager.self)
        return permissions.allowed(R.self, action, as: self)
    }
    
    func authorize<R>(_: R.Type, _ action: R.Action, on container: Container) throws where R: Resource {
        guard try can(R.self, action, on: container) else {
            throw Abort(.forbidden)
        }
    }
    
    func can<R>(_ resource: R, _ action: R.Action, on container: Container) throws -> Bool where R: Resource {
        let permissions = try container.make(PermissionManager.self)
        return permissions.allowed(resource, action, as: self)
    }
    
    func authorize<R>(_ resource: R, _ action: R.Action, on container: Container) throws where R: Resource {
        guard try can(resource, action, on: container) else {
            throw Abort(.forbidden)
        }
    }
    
}
