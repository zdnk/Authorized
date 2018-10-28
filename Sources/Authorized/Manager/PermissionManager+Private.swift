import Foundation

extension PermissionManager {
    
    internal func resolve<R, A>(_ permissions: [Permission], _: R.Type, resource: R?, user: A) -> Bool where R: Protected, A: Authorizable {
        var result = false
        
        for permission in permissions {
            let current = permission.resolve(
                R.self,
                resource: resource,
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
    
    internal func resources<T: Authorizable>(for user: T) -> UserResources? {
        return userResources[T.authorizableIdentifier]
    }
    
    internal func permissions<A: Authorizable>(action: String, resource: String, user: A, instance: Bool) -> [Permission] {
        guard let resources = self.resources(for: user) else {
            return []
        }
        
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: resource,
            action: action,
            isInstance: instance
        )
        
        return resources.permissions(for: request)
    }
    
    internal func createPermission(with request: PermissionRequest, deny: Bool, resolver: PermissionResolving) {
        if userResources[request.authorizableIdentifier] == nil {
            userResources[request.authorizableIdentifier] = UserResources(request.authorizableIdentifier)
        }
        
        if userResources[request.authorizableIdentifier]?.resources[request.resourceIdentifier] == nil {
            userResources[request.authorizableIdentifier]?
                .resources[request.resourceIdentifier] = Resource(request.resourceIdentifier)
        }
        
        let permission = Permission(
            action: request.actionIdentifier,
            instance: request.isInstance,
            deny: deny,
            resolver: resolver
        )
        
        userResources[request.authorizableIdentifier]?
            .resources[request.resourceIdentifier]?
            .addOrReplace(with: permission)
    }
    
}
