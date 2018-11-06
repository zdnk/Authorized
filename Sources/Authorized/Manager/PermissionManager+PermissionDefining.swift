import Foundation

extension PermissionManager: PermissionDefining {
    
    open func define(with request: PermissionRequest, resolver: PermissionResolving) {
        createPermission(
            with: request,
            resolver: resolver
        )
    }
    
}
