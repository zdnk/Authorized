import Vapor

public protocol PermissionDefining {
    
    func define(with: PermissionRequest, resolver: PermissionResolving)
    func before(_ closure: @escaping (BeforeContext) throws -> Future<PermissionResolution?>)
    
}
