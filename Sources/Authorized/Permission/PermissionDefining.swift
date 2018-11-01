import Foundation

public protocol PermissionDefining {
    
    func define(with: PermissionRequest, resolver: PermissionResolving)
    
}
