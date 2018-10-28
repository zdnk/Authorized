import Foundation

public struct ClosurePermissionResolver<P: Protected, A: Authorizable>: PermissionResolving {
    
    let closure: (P, A) -> Bool
    
    public init(_ closure: @escaping (P, A) -> Bool) {
        self.closure = closure
    }
    
    public func resolve<R, U>(_: R.Type, resource: R?, user: U) -> Bool where R: Protected, U: Authorizable {
        guard let resource = resource as? P else {
            return false
        }
        
        guard let user = user as? A else {
            return false
        }
        
        return closure(resource, user)
    }
    
}
