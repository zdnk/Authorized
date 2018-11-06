import Vapor

public struct PermissionsConfig: Service {
    
    public private(set) var policies: [Policy] = []
    
    public init() {}
    
    public mutating func add(policy: Policy) {
        policies.append(policy)
    }
    
    internal func makePermissions() throws -> PermissionManager {
        let repository = PermissionRepository()
        let manager = PermissionManager(repository: repository)
        
        for policy in policies {
            try policy.configure(in: manager)
        }
        
        return manager
    }
    
}
