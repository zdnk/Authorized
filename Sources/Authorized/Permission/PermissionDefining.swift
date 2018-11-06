import Vapor

public protocol PermissionDefining {
    
    func define(with: PermissionRequest, resolver: PermissionResolving)
    func before<R, A>(_ closure: @escaping (ResourceTarget<R>, R.Action, A, Container) throws -> Future<PermissionResolution?>) where R: Resource, A: Authorizable
    
}

extension PermissionDefining {
    
    public func before<R, A>(_ closure: @escaping (R, R.Action, A, Container) throws -> Future<PermissionResolution?>) where R: Resource, A: Authorizable {
        before { (target: ResourceTarget<R>, action: R.Action, user: A, container: Container) -> EventLoopFuture<PermissionResolution?> in
            guard case .instance(let resource) = target else {
                return container.future(nil)
            }
            
            return try closure(resource, action, user, container)
        }
    }
    
    public func before<R, A>(_ closure: @escaping (R.Type, R.Action, A, Container) throws -> Future<PermissionResolution?>) where R: Resource, A: Authorizable {
        before { (target: ResourceTarget<R>, action: R.Action, user: A, container: Container) -> EventLoopFuture<PermissionResolution?> in
            guard case .type = target else {
                return container.future(nil)
            }
            
            return try closure(R.self, action, user, container)
        }
    }
    
}
