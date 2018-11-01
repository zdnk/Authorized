import Foundation

public struct SimplePermissionResolver: PermissionResolving {
    
    public let value: PermissionResolution
    
    public init(value: PermissionResolution) {
        self.value = value
    }
    
    public func resolve<R, U>(target: ResourceTarget<R>, user: U) -> PermissionResolution where R: Resource, U: Authorizable {
        return value
    }
    
}
