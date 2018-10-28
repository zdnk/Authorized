import Vapor

public struct PermissionsProvider: Provider {
    
    public func register(_ services: inout Services) throws {
        services.register(Permissions.self, factory: { container -> PermissionManager in
            let config = try container.make(PermissionsConfig.self)
            return try config.makePermissions()
        })
    }
    
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
    
}
