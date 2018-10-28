import Foundation

open class PermissionManager: Permissions {

    internal var userResources: [String: UserResources] = [:]
    
    public required init() {}
    
    open func allowed<R, A>(_ resource: R, _ action: R.Action, as user: A) -> Bool where R: Protected, A: Authorizable {
        let permissions = self.permissions(
            action: action.actionIdentifier,
            resource: R.resourceIdentifier,
            user: user,
            instance: true
        )
        
        return self.resolve(
            permissions,
            R.self,
            resource: resource,
            user: user
        )
    }
    
    open func allowed<R, A>(_ resource: R.Type, _ action: R.Action, as user: A) -> Bool where R: Protected, A: Authorizable {
        let permissions = self.permissions(
            action: action.actionIdentifier,
            resource: R.resourceIdentifier,
            user: user,
            instance: false
        )
        
        return self.resolve(
            permissions,
            R.self,
            resource: nil,
            user: user
        )
    }
    
}
