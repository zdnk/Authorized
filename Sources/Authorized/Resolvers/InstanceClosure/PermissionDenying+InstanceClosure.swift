import Foundation

extension PermissionDenying {
    
    public func deny<R, A>(_ resource: R.Type, _ action: R.Action, for user: A.Type, _ resolve: @escaping (R, A) -> Bool) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: true
        )
        
        deny(
            with: request,
            resolver: InstanceClosurePermissionResolver(resolve)
        )
    }
    
}
