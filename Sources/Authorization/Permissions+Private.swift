import Foundation

extension Permissions {
    
    internal func resources<T: Authorizable>(for user: T) -> UserResources? {
        return userResources[T.authorizableIdentifier]
    }
    
    internal func resolver<A: Authorizable>(action: String, resource: String, user: A, instance: Bool) -> PermissionResolving? {
        guard let resources = self.resources(for: user) else {
            return nil
        }
        
        if instance, let permission = resources.permission(
            action: action,
            resource: resource,
            instance: true
        ) {
            return permission.resolver
        }
        
        return resources.permission(
            action: action,
            resource: resource,
            instance: false
            )?.resolver
    }
    
    internal func createPermission(user: String, resource: String, action: String, instance: Bool, resolver: PermissionResolving) {
        if userResources[user] == nil {
            userResources[user] = UserResources(user)
        }
        
        if userResources[user]?.resources[resource] == nil {
            userResources[user]?.resources[resource] = Resource(resource)
        }
        
        if var act = userResources[user]?.resources[resource]?.action(for: action, instance: instance) {
            userResources[user]?.resources[resource]?.actions.remove(act)
            act.resolver = resolver
            userResources[user]?.resources[resource]?.actions.insert(act)
        } else {
            let act = Action(
                action,
                instance: instance,
                resolver: resolver
            )
            
            userResources[user]?.resources[resource]?.actions.insert(act)
        }
        
    }
    
}
