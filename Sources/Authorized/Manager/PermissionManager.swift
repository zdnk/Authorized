import Foundation

open class PermissionManager: Permissions {

    internal var repository: PermissionRepository
    
    public required init(repository: PermissionRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: PermissionRepository())
    }
    
    open func allowed<R, A>(_ target: ResourceTarget<R>, _ action: R.Action, as user: A) -> Bool where R : Resource, A : Authorizable {
        let permissions = self.permissions(
            action: action.actionIdentifier,
            resource: R.resourceIdentifier,
            user: user,
            instance: target.isInstance
        )
        
        let result = self.resolve(
            permissions,
            target: target,
            user: user
        )
        
        return result == .allow
    }
    
}
