import Foundation
import Vapor

public struct SimplePermissionResolver: PermissionResolving {
    
    public let value: PermissionResolution
    
    public init(value: PermissionResolution) {
        self.value = value
    }
    
    public func resolve<R, U>(target: ResourceTarget<R>, user: U, on container: Container) -> Future<PermissionResolution> where R: Resource, U: Authorizable {
        return container.future(value)
    }
    
}
