import Foundation

extension PermissionManager: PermissionDenying {
    
    open func deny(with request: PermissionRequest, resolver: PermissionResolving) {
        createPermission(
            with: request,
            resolver: resolver
        )
    }
    
}
