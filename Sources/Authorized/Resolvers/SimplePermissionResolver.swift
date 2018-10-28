import Foundation

struct SimplePermissionResolver: PermissionResolving {
    
    let value: Bool
    
    func resolve<R, U>(_: R.Type, resource: R?, user: U) -> Bool where R: Resource, U: Authorizable {
        return value
    }
    
}
