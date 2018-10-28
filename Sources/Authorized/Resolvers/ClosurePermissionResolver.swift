import Foundation

public struct ClosurePermissionResolver<P: Resource, A: Authorizable>: PermissionResolving {
    
    let closure: (P, A) -> Bool
    
    public init(_ closure: @escaping (P, A) -> Bool) {
        self.closure = closure
    }
    
    public func resolve<R, U>(_: R.Type, resource: R?, user: U) -> Bool where R: Resource, U: Authorizable {
        guard let resource = resource as? P else {
            return false
        }
        
        guard let user = user as? A else {
            return false
        }
        
        return closure(resource, user)
    }
    
}
