import Foundation

public struct PermissionRepository {
    
    public typealias Collection = [String: [Permission]]
    
    internal var grants = Collection()
    internal var denies = Collection()
    
    public init() {}
    
    public mutating func define(with request: PermissionRequest, isDeny: Bool, resolver: PermissionResolving) {
        let id = request.isInstance ? request.instanceIdentifier : request.identifier
        
        let permission = Permission(
            authorizable: request.authorizable,
            resource: request.resource,
            action: request.action,
            instance: request.isInstance,
            deny: isDeny,
            resolver: resolver
        )
        
        if isDeny {
            if denies[id] == nil {
                denies[id] = []
            }
            
            denies[id]?.append(permission)
        } else {
            if grants[id] == nil {
                grants[id] = []
            }
            grants[id]?.append(permission)
        }
    }
    
    public func permissions(for request: PermissionRequest) -> [Permission] {
        var result: [Permission] = []
        
        if request.isInstance {
            
            addIfExists(request.instanceIdentifier, in: denies, to: &result)
            addIfExists(request.instanceIdentifier, in: grants, to: &result)
        }
        
        addIfExists(request.identifier, in: denies, to: &result)
        addIfExists(request.identifier, in: grants, to: &result)
        
        return result
    }
    
}
