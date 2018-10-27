import Foundation
import Vapor

open class Permissions: Service {

    internal var userResources: [String: UserResources] = [:]
    
    open func allowed<R, A>(_ resource: R, _ action: R.Action, as user: A) -> Bool where R: Protected, A: Authorizable {
        let resolver = self.resolver(
            action: action.actionIdentifier,
            resource: R.resourceIdentifier,
            user: user,
            instance: true
        )
        
        return resolver?.resolve(resource: resource, user: user) ?? false
    }
    
    open func allowed<R, A>(_ resource: R.Type, _ action: R.Action, as user: A) -> Bool where R: Protected, A: Authorizable {
        let resolver = self.resolver(
            action: action.actionIdentifier,
            resource: R.resourceIdentifier,
            user: user,
            instance: false
        )
        
        return resolver?.resolve(resource: resource, user: user) ?? false
    }
    
    open func allow<R, A>(_ resource: R.Type, _ action: R.Action, for user: A.Type) where R: Protected, A: Authorizable {
        createPermission(
            user: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            instance: false,
            resolver: StaticPermissionResolver(value: true)
        )
    }
    
    open func allow<R, A>(_ resource: R.Type, _ action: R.Action, for user: A.Type, _ resolve: @escaping (R, A) -> Bool) where R: Protected, A: Authorizable {
        createPermission(
            user: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            instance: true,
            resolver: InstancePermissionResolver(resolve)
        )
    }
    
}
