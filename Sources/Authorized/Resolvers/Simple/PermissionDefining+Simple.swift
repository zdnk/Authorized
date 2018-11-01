import Foundation

extension PermissionDefining {
    
    public func allow<R, A>(_ resource: R.Type, _ action: R.Action, as user: A.Type) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: false
        )
        
        define(
            with: request,
            resolver: SimplePermissionResolver(value: .allow)
        )
    }
    
    public func deny<R, A>(_ resource: R.Type, _ action: R.Action, as user: A.Type) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: false
        )
        
        define(
            with: request,
            resolver: SimplePermissionResolver(value: .deny)
        )
    }
    
}
