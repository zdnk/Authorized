import Foundation

extension PermissionDenying {
    
    public func deny<R, A>(_ resource: R.Type, _ action: R.Action, as user: A.Type) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: false
        )
        
        deny(
            with: request,
            resolver: SimplePermissionResolver(value: true)
        )
    }
    
}
