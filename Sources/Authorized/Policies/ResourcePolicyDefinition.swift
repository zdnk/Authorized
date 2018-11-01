import Foundation

public struct ResourcePolicyDefinition<R: Resource> {
    
    var map: [String: [String: PermissionResolving]] = [:]
    
    public mutating func action<A>(_ action: R.Action, to: (R, A) -> PermissionResolution) where A: Authorizable {
        
    }
    
    public mutating func action<A>(_ action: R.Action, to: (A) -> PermissionResolution) where A: Authorizable {
        
    }
    
    private mutating func add<A>(action: R.Action, as: A.Type, resolver: PermissionResolving) {
        
    }
    
    internal func add(to config: PermissionDefining) {
        
    }
    
}
