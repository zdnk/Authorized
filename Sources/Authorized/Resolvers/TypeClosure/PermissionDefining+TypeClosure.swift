import Foundation
import Vapor

extension PermissionDefining {
    
    public func allow<R, A>(_ resource: R.Type, _ action: R.Action, as user: A.Type, _ resolve: @escaping (A, Container) -> Future<Bool>) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: true
        )
        
        define(
            with: request,
            resolver: TypeClosurePermissionResolver<R, A>{ _, user, container in
                return resolve(user, container).map { $0 ? .allow : .deny }
            }
        )
    }
    
    public func deny<R, A>(_ resource: R.Type, _ action: R.Action, as user: A.Type, _ resolve: @escaping (A, Container) -> Future<Bool>) where R: Resource, A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.authorizableIdentifier,
            resource: R.resourceIdentifier,
            action: action.actionIdentifier,
            isInstance: true
        )
        
        define(
            with: request,
            resolver: TypeClosurePermissionResolver<R, A> { _, user, container in
                return resolve(user, container).map { $0 ? .deny : .allow }
            }
        )
    }
    
}
