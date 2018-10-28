import Foundation

public struct InstanceClosurePermissionResolver<P: Resource, A: Authorizable>: PermissionResolving {
    
    let closure: (P, A) -> Bool
    
    public init(_ closure: @escaping (P, A) -> Bool) {
        self.closure = closure
    }
    
    public func resolve<R, U>(target: ResourceTarget<R>, user: U) -> Bool where R: Resource, U: Authorizable {
        guard case ResourceTarget.instance(let resource) = target else {
            preconditionFailure("Resource target is not instance.")
        }
        
        guard let typeResource = resource as? P else {
            preconditionFailure("Resource target cannot be casted to \(P.self)")
        }
        
        guard let user = user as? A else {
            preconditionFailure("Authorizable cannot be casted to \(A.self)")
        }
        
        return closure(typeResource, user)
    }
    
}
