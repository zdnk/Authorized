import Foundation

public protocol Permissions {
    
    func allowed<R, A>(_: R, _: R.Action, as: A) -> Bool where R: Resource, A: Authorizable
    
    func allowed<R, A>(_: R.Type, _: R.Action, as: A) -> Bool where R: Resource, A: Authorizable
    
    func allow(with: PermissionRequest, resolver: PermissionResolving)
    
    func deny(with: PermissionRequest, resolver: PermissionResolving)
    
}

extension Permissions {
    
    public func allow<R, A>(_ resource: R.Type, _ action: R.Action, for user: A.Type) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: false
        )
        
        allow(
            with: request,
            resolver: StaticPermissionResolver(value: true)
        )
    }
    
    public func allow<R, A>(_ resource: R.Type, _ action: R.Action, for user: A.Type, _ resolve: @escaping (R, A) -> Bool) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: true
        )
        
        allow(
            with: request,
            resolver: ClosurePermissionResolver(resolve)
        )
    }
    
}
