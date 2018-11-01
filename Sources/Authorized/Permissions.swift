import Foundation
import Vapor

public typealias Permissions = PermissionVerifying

public protocol PermissionDefining {
    
    func define(with: PermissionRequest, resolver: PermissionResolving)
    
}

public protocol PermissionVerifying {
    
    func allowed<R, A>(_: ResourceTarget<R>, _: R.Action, as: A) -> Bool where R: Resource, A: Authorizable
    
}

extension PermissionVerifying {
    
    public func authorize<R, A>(_ resource: R, _ action: R.Action, as user: A) throws where R: Resource, A: Authorizable{
        guard allowed(resource, action, as: user) else {
            throw Abort(.forbidden)
        }
    }
    
    public func authorize<R, A>(_ resource: R.Type, _ action: R.Action, as user: A) throws where R: Resource, A: Authorizable{
        guard allowed(R.self, action, as: user) else {
            throw Abort(.forbidden)
        }
    }
    
    public func allowed<R, A>(_ resource: R, _ action: R.Action, as user: A) -> Bool where R: Resource, A: Authorizable {
        return allowed(
            .instance(resource),
            action, as:
            user
        )
    }
    
    public func allowed<R, A>(_: R.Type, _ action: R.Action, as user: A) -> Bool where R: Resource, A: Authorizable {
        return allowed(
            ResourceTarget<R>.type,
            action, as:
            user
        )
    }
    
}
