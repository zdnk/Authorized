import Foundation

extension PermissionGranting {
    
    public mutating func allow<R, A>(_ resource: R.Type, _ action: R.Action, for user: A.Type) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: false
        )
        
        allow(
            with: request,
            resolver: SimplePermissionResolver(value: true)
        )
    }
    
}
