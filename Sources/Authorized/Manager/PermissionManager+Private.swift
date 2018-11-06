import Foundation
import Vapor

extension PermissionManager {
    
    internal func resolve<R, A>(_ permissions: [Permission], target: ResourceTarget<R>, user: A, on container: Container) -> Future<PermissionResolution> where R: Resource, A: Authorizable {
        if permissions.count == 0 {
            return container.future(.deny)
        }
        
        var futures = [Future<PermissionResolution>]()
        for permission in permissions {
            let future = permission.resolve(
                target: target,
                user: user,
                on: container
            )
            
            futures.append(future)
        }
        
        return futures
            .flatten(on: container)
            .map { resoltions -> PermissionResolution in
                if resoltions.contains(.deny) {
                    return .deny
                }
                
                return .allow
            }
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
    
    internal func createPermission(with request: PermissionRequest, resolver: PermissionResolving) {
        repository.define(with: request, resolver: resolver)
    }
    
}
