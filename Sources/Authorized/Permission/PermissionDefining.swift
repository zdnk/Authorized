import Vapor

public protocol PermissionDefining {
    
    func define(with: PermissionRequest, resolver: PermissionResolving)
    func before(_ closure: @escaping (Any, Any, Authorizable, Container) throws -> Future<PermissionResolution?>)
    
}
