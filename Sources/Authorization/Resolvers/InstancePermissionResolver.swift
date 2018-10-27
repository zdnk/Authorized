import Foundation

struct InstancePermissionResolver<P: Protected, A: Authorizable>: PermissionResolving {
    
    let closure: (P, A) -> Bool
    
    init(_ closure: @escaping (P, A) -> Bool) {
        self.closure = closure
    }
    
    func resolve(resource: Any, user: Any) -> Bool {
        guard let resource = resource as? P else {
            return false
        }
        
        guard let user = user as? A else {
            return false
        }
        
        return closure(resource, user)
    }
    
}
