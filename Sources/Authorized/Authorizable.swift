import Vapor

public protocol Authorizable {
    
    static var authorizableIdentifier: String { get }
    
}

extension Authorizable {
    
    public static var authorizableIdentifier: String {
        return String(describing: Self.self)
    }
    
    func can<R>(_: R.Type, _ action: R.Action, on container: Container) throws -> Future<Bool> where R: Resource {
        let permissions = try container.make(PermissionManager.self)
        return permissions.allowed(R.self, action, as: self, on: container)
    }
    
    func authorize<R>(_: R.Type, _ action: R.Action, on container: Container) throws -> Future<Void> where R: Resource {
        return try can(R.self, action, on: container)
            .map { result in
                guard result else {
                    throw Abort(.forbidden)
                }
            }
    }
    
    func can<R>(_ resource: R, _ action: R.Action, on container: Container) throws -> Future<Bool> where R: Resource {
        let permissions = try container.make(PermissionManager.self)
        return permissions.allowed(resource, action, as: self, on: container)
    }
    
    func authorize<R>(_ resource: R, _ action: R.Action, on container: Container) throws -> Future<R> where R: Resource {
        return try can(resource, action, on: container)
            .map { result in
                guard result else {
                    throw Abort(.forbidden)
                }
                
                return resource
            }
    }
    
}
