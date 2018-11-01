import Foundation

public struct PermissionRepository {
    
    public typealias Collection = [String: [Permission]]
    
    internal var storage = Collection()
    
    public init() {}
    
    public mutating func define(with request: PermissionRequest, resolver: PermissionResolving) {
        let id = request.isInstance ? request.instanceIdentifier : request.identifier
        
        let permission = Permission(
            authorizable: request.authorizable,
            resource: request.resource,
            action: request.action,
            instance: request.isInstance,
            resolver: resolver
        )
        
        if storage[id] == nil {
            storage[id] = []
        }
        
        storage[id]?.append(permission)
    }
    
    public func permissions(for request: PermissionRequest) -> [Permission] {
        var result: [Permission] = []
        
        if request.isInstance {
            addIfExists(request.instanceIdentifier, in: storage, to: &result)
        }
        
        addIfExists(request.identifier, in: storage, to: &result)
        
        return result
    }
    
}
