import Foundation

public protocol PermissionResolving {
    
    func resolve<R, U>(_: R.Type, resource: R?, user: U) -> Bool where R: Protected, U: Authorizable
    
}
