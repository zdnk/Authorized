import Foundation
import Vapor

extension PermissionManager {
    
    internal func before<R, A>(_ target: ResourceTarget<R>, _ action: R.Action, as user: A, on container: Container) -> Future<PermissionResolution?> where R: Resource, A: Authorizable {
        
        var beforeFutures: [Future<PermissionResolution?>] = []
        
        do {
            let context = BeforeContext(
                target: target,
                action: action,
                user: user,
                container: container
            )
            
            try beforeClosures.forEach { closure in
                let future = try closure(context)
                beforeFutures.append(future)
            }
        } catch {
            return container.future(.deny)
        }
        
        return beforeFutures
            .flatten(on: container)
            .map { results -> PermissionResolution? in
                if results.contains(.deny) {
                    return .deny
                }
                
                if results.contains(.allow) {
                    return .allow
                }
                
                return nil
        }
    }
    
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
