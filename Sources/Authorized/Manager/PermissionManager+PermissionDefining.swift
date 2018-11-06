import Vapor

extension PermissionManager: PermissionDefining {
    
    open func define(with request: PermissionRequest, resolver: PermissionResolving) {
        createPermission(
            with: request,
            resolver: resolver
        )
    }
    
    open func before<R, A>(_ closure: @escaping (ResourceTarget<R>, R.Action, A, Container) throws -> EventLoopFuture<PermissionResolution?>) where R : Resource, A : Authorizable {
        let resolve: BeforeClosure = { anyTarget, anyAction, anyUser, container in
            guard let target = anyTarget as? ResourceTarget<R>,
                let user = anyUser as? A,
                let action = anyAction as? R.Action else {
                return container.future(nil)
            }
            
            return try closure(target, action, user, container)
        }
        
        beforeClosures.append(resolve)
    }
    
}
