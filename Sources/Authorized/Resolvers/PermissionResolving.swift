import Foundation

public protocol PermissionResolving {
    
    func resolve<R, U>(target: ResourceTarget<R>, user: U) -> PermissionResolution where R: Resource, U: Authorizable
    
}
