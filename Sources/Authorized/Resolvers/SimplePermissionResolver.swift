import Foundation

struct SimplePermissionResolver: PermissionResolving {
    
    let value: Bool
    
    func resolve<R, U>(target: ResourceTarget<R>, user: U) -> Bool where R: Resource, U: Authorizable {
        return value
    }
    
}
