import Foundation
import Vapor

open class Permissions: Service {

    internal var userResources: [String: UserResources] = [:]
    
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
    
    open func allow<R, A>(_ resource: R.Type, _ action: R.Action, for user: A.Type) where R: Protected, A: Authorizable {
        createPermission(
            user: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            instance: false,
            deny: false,
            resolver: StaticPermissionResolver(value: true)
        )
    }
    
    open func allow<R, A>(_ resource: R.Type, _ action: R.Action, for user: A.Type, _ resolve: @escaping (R, A) -> Bool) where R: Protected, A: Authorizable {
        createPermission(
            user: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            instance: true,
            deny: false,
            resolver: InstancePermissionResolver(resolve)
        )
    }
    
}
