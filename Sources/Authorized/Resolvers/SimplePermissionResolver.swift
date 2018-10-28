import Foundation

public struct SimplePermissionResolver: PermissionResolving {
    
    public let value: Bool
    
    public init(value: Bool) {
        self.value = value
    }
    
    public func resolve<R, U>(target: ResourceTarget<R>, user: U) -> Bool where R: Resource, U: Authorizable {
        return value
    }
    
}
