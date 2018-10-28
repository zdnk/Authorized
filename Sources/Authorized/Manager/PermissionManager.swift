import Foundation

open class PermissionManager: Permissions {

    internal var repository: PermissionRepository
    
    public required init(repository: PermissionRepository) {
        self.repository = repository
    }
    
    open func allowed<R, A>(_ resource: R, _ action: R.Action, as user: A) -> Bool where R: Resource, A: Authorizable {
        let permissions = self.permissions(
            action: action.actionIdentifier,
            resource: R.resourceIdentifier,
            user: user,
            instance: true
        )
        
        return self.resolve(
            permissions,
            target: .instance(resource),
            user: user
        )
    }
    
    open func allowed<R, A>(_ resource: R.Type, _ action: R.Action, as user: A) -> Bool where R: Resource, A: Authorizable {
        let permissions = self.permissions(
            action: action.actionIdentifier,
            resource: R.resourceIdentifier,
            user: user,
            instance: false
        )
        
        return self.resolve(
            permissions,
            target: ResourceTarget<R>.type,
            user: user
        )
    }
    
}
