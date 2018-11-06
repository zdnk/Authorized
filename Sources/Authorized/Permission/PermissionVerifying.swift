import Foundation
import Vapor

public protocol PermissionVerifying {
    
    func allowed<R, A>(_: ResourceTarget<R>, _: R.Action, as: A, on: Container) -> Future<Bool> where R: Resource, A: Authorizable
    
}

extension PermissionVerifying {
    
    public func authorize<R, A>(_ resource: R, _ action: R.Action, as user: A, on container: Container) -> Future<R> where R: Resource, A: Authorizable{
        return allowed(resource, action, as: user, on: container)
            .map { result in
                guard result else {
                    throw Abort(.forbidden)
                }
                
                return resource
            }
    }
    
    public func authorize<R, A>(_ resource: R.Type, _ action: R.Action, as user: A, on container: Container) -> Future<Void> where R: Resource, A: Authorizable{
        return allowed(R.self, action, as: user, on: container)
            .map { result in
                guard result else {
                    throw Abort(.forbidden)
                }
            }
    }
    
    public func allowed<R, A>(_ resource: R, _ action: R.Action, as user: A, on container: Container) -> Future<Bool> where R: Resource, A: Authorizable {
        return allowed(
            .instance(resource),
            action,
            as: user,
            on: container
        )
    }
    
    public func allowed<R, A>(_: R.Type, _ action: R.Action, as user: A, on container: Container) -> Future<Bool> where R: Resource, A: Authorizable {
        return allowed(
            ResourceTarget<R>.type,
            action,
            as:user,
            on: container
        )
    }
    
}
