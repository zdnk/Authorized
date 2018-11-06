import Vapor

extension PermissionManager: PermissionDefining {
    
    open func define(with request: PermissionRequest, resolver: PermissionResolving) {
        createPermission(
            with: request,
            resolver: resolver
        )
    }
    
    open func before(_ closure: @escaping BeforeClosure) {
        
        beforeClosures.append(closure)
    }
    
}
