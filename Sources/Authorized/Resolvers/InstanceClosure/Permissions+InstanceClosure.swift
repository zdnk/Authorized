import Foundation

extension PermissionGranting {
    
    public mutating func allow<R, A>(_ resource: R.Type, _ action: R.Action, for user: A.Type, _ resolve: @escaping (R, A) -> Bool) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: true
        )
        
        allow(
            with: request,
            resolver: InstanceClosurePermissionResolver(resolve)
        )
    }
    
}
