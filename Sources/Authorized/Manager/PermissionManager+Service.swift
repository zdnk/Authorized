import Vapor

extension PermissionManager: ServiceType {
    
    public static var serviceSupports: [Any.Type] {
        return [Permissions.self]
    }
    
    public static func makeService(for worker: Container) throws -> Self {
        return .init()
    }
    
}
