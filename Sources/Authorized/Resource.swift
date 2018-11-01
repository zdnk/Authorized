import Foundation
import Vapor

public protocol Resource {
    
    associatedtype Action: ResourceAction
    
    static var resourceIdentifier: String { get }
    
}

extension Resource {
    
    public static var resourceIdentifier: String {
        return String(describing: Self.self)
    }
    
}

extension Future where T: Resource {
    
    public func authorize<A: Authorizable>(_ action: T.Action, as user: A, on container: Container) -> Future<T> {
        return map { resource -> T in
            let permissions = try container.make(PermissionVerifying.self)
            try permissions.authorize(resource, action, as: user)
            return resource
        }
    }
    
}
