import Foundation

extension PermissionManager {
    
    internal func resolve<R, A>(_ permissions: [Permission], target: ResourceTarget<R>, user: A) -> PermissionResolution where R: Resource, A: Authorizable {
        var result = PermissionResolution.deny
        
        for permission in permissions {
            result = permission.resolve(
                target: target,
                user: user
            )
            
            if result == .deny {
                break
            }
        }
        
        return result
    }
    
    internal func permissions<A: Authorizable>(action: String, resource: String, user: A, instance: Bool) -> [Permission] {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: resource,
            action: action,
            isInstance: instance
        )
        
        return repository.permissions(for: request)
    }
    
    internal func createPermission(with request: PermissionRequest, resolver: PermissionResolving) {
        repository.define(with: request, resolver: resolver)
    }
    
}
