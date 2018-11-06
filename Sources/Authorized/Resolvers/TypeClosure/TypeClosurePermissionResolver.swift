import Foundation

public struct TypeClosurePermissionResolver<P: Resource, A: Authorizable>: PermissionResolving {
    
    public typealias ResolutionClosure = (P.Type, A) -> PermissionResolution
    
    let closure: ResolutionClosure
    
    public init(_ closure: @escaping ResolutionClosure) {
        self.closure = closure
    }
    
    public func resolve<R, U>(target: ResourceTarget<R>, user: U) -> PermissionResolution where R: Resource, U: Authorizable {
        guard case ResourceTarget.type = target else {
            preconditionFailure("Resource target is not type.")
        }
        
        guard let user = user as? A else {
            preconditionFailure("Authorizable cannot be casted to \(A.self)")
        }
        
        return closure(P.self, user)
    }
    
}
