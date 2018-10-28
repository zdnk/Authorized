import Foundation

extension Permissions {
    
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
        
        return resources.permissions(
            action: action,
            resource: resource,
            instance: instance
        )
    }
    
    internal func createPermission(user: String, resource: String, action: String, instance: Bool, deny: Bool, resolver: PermissionResolving) {
        if userResources[user] == nil {
            userResources[user] = UserResources(user)
        }
        
        if userResources[user]?.resources[resource] == nil {
            userResources[user]?.resources[resource] = Resource(resource)
        }
        
        let permission = Permission(
            action: action,
            instance: instance,
            deny: deny,
            resolver: resolver
        )
        
        userResources[user]?.resources[resource]?.addOrReplace(with: permission)
    }
    
}
