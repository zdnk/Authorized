import Foundation

extension PermissionManager {
    
    open func allow(with request: PermissionRequest, resolver: PermissionResolving) {
        createPermission(
            with: request,
            deny: false,
            resolver: resolver
        )
    }
    
}
