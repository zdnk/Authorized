import Foundation
import Vapor

public struct InstanceClosurePermissionResolver<P: Resource, A: Authorizable>: PermissionResolving {
    
    public typealias ResolutionClosure = (P, A, Container) -> Future<PermissionResolution>
    
    let closure: ResolutionClosure
    
    public init(_ closure: @escaping ResolutionClosure) {
        self.closure = closure
    }
    
    public func resolve<R, U>(target: ResourceTarget<R>, user: U, on container: Container) -> Future<PermissionResolution> where R: Resource, U: Authorizable {
        guard case ResourceTarget.instance(let resource) = target else {
            preconditionFailure("Resource target is not instance.")
        }
        
        guard let typeResource = resource as? P else {
            preconditionFailure("Resource target cannot be casted to \(P.self)")
        }
        
        guard let user = user as? A else {
            preconditionFailure("Authorizable cannot be casted to \(A.self)")
        }
        
        return closure(typeResource, user, container)
    }
    
}
