import Foundation
import Vapor

public struct ResourcePolicyMapping<R: Resource> {
    
    public enum Error: Swift.Error {
        case alreadyExists(action: R.Action, authorizable: Authorizable.Type)
    }
    
    var map: [String: [String: (PermissionRequest, PermissionResolving)]] = [:]
    
    public init() {}
    
    public mutating func action<A>(_ action: R.Action, to: @escaping (R, A, Container) -> Future<PermissionResolution>) throws where A: Authorizable {
        let resolver = InstanceClosurePermissionResolver(to)
        
        try add(action: action, as: A.self, instance: true, resolver: resolver)
    }
    
    public mutating func action<A>(_ action: R.Action, to: @escaping (A, Container) -> Future<PermissionResolution>) throws where A: Authorizable {
        let resolver = TypeClosurePermissionResolver<R, A>() { _, user, container in
            return to(user, container)
        }

        try add(action: action, as: A.self, instance: true, resolver: resolver)
    }
    
    private mutating func add<A>(action: R.Action, as user: A.Type, instance: Bool, resolver: PermissionResolving) throws where A: Authorizable {
        if map[action.actionIdentifier] == nil {
            map[action.actionIdentifier] = [:]
        }
        
        if map[action.actionIdentifier]?[A.authorizableIdentifier] != nil {
            throw Error.alreadyExists(action: action, authorizable: A.self)
        }
        
        let request = PermissionRequest(
            authorizable: A.self,
            resource: R.self,
            action: action,
            isInstance: instance
        )
        
        map[action.actionIdentifier]?[A.authorizableIdentifier] = (request, resolver)
    }
    
    internal func add(to config: PermissionDefining) {
        map.values
            .forEach {
                $0.forEach {
                    config.define(with: $0.value.0, resolver: $0.value.1)
                }
            }
    }
    
}
