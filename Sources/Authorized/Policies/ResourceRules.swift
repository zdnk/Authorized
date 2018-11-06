import Foundation
import Vapor

public struct ResourceRules<R: Resource> {
    
    var rules: [(PermissionRequest, PermissionResolving)] = []
    
    public init() {}
    
    public mutating func add<A>(_ to: @escaping (R, A, Container) throws -> Future<PermissionResolution>, for action: R.Action) where A: Authorizable {
        let resolver = InstanceClosurePermissionResolver(to)
        
        add(action: action, as: A.self, instance: true, resolver: resolver)
    }
    
    public mutating func add<A>(_ to: @escaping (A, Container) throws -> Future<PermissionResolution>, for action: R.Action) where A: Authorizable {
        let resolver = TypeClosurePermissionResolver<R, A>() { _, user, container in
            return try to(user, container)
        }

        add(action: action, as: A.self, instance: true, resolver: resolver)
    }
    
    private mutating func add<A>(action: R.Action, as user: A.Type, instance: Bool, resolver: PermissionResolving) where A: Authorizable {
        let request = PermissionRequest(
            authorizable: A.self,
            resource: R.self,
            action: action,
            isInstance: instance
        )
        
        rules.append((request, resolver))
    }
    
    internal func add(to config: PermissionDefining) {
        rules.forEach {
            config.define(with: $0.0, resolver: $0.1)
        }
    }
    
}
