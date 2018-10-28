import Foundation

public struct PermissionRepository {
    
    internal var allows: [String: Permission] = [:]
    internal var denies: [String: Permission] = [:]
    
    public init() {}
    
    public mutating func defineOrReplace(with request: PermissionRequest, isDeny: Bool, resolver: PermissionResolving) {
        let id = request.isInstance ? request.instanceIdentifier : request.identifier
        
        let permission = Permission(
            action: request.actionIdentifier,
            instance: request.isInstance,
            deny: isDeny,
            resolver: resolver
        )
        
        if isDeny {
            denies[id] = permission
        } else {
            allows[id] = permission
        }
    }
    
    public func permissions(for request: PermissionRequest) -> [Permission] {
        var result: [Permission] = []
        
        if request.isInstance {
            
            addIfExists(request.instanceIdentifier, in: denies, to: &result)
            addIfExists(request.instanceIdentifier, in: allows, to: &result)
        }
        
        addIfExists(request.identifier, in: denies, to: &result)
        addIfExists(request.identifier, in: allows, to: &result)
        
        return result
    }
    
}

extension PermissionRequest {
    
    fileprivate var identifier: String {
        return [
            self.authorizableIdentifier,
            self.resourceIdentifier,
            self.actionIdentifier
        ].joined(separator: ".")
    }
    
    fileprivate var instanceIdentifier: String {
        return "#\(identifier)"
    }
    
}
