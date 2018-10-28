import Foundation

extension PermissionManager {
    
    open func deny(with request: PermissionRequest, resolver: PermissionResolving) {
        createPermission(
            with: request,
            deny: true,
            resolver: resolver
        )
    }
    
}
