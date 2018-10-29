import Foundation

extension PermissionManager {
    
    internal func resolve<R, A>(_ permissions: [Permission], target: ResourceTarget<R>, user: A) -> Bool where R: Resource, A: Authorizable {
        var result = false
        
        for permission in permissions {
            let current = permission.resolve(
                target: target,
                user: user
            )
            
            guard current else {
                continue
            }
            
            if !permission.isDeny {
                result = true
                continue
            } else {
                result = false
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
    
    internal func createPermission(with request: PermissionRequest, deny: Bool, resolver: PermissionResolving) {
        repository.define(with: request, isDeny: deny, resolver: resolver)
    }
    
}
