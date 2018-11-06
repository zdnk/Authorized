import Foundation
import Vapor

public struct TypeClosurePermissionResolver<P: Resource, A: Authorizable>: PermissionResolving {
    
    public typealias ResolutionClosure = (P.Type, A, Container) throws -> Future<PermissionResolution>
    
    let closure: ResolutionClosure
    
    public init(_ closure: @escaping ResolutionClosure) {
        self.closure = closure
    }
    
    public func resolve<R, U>(target: ResourceTarget<R>, user: U, on container: Container) throws -> Future<PermissionResolution> where R: Resource, U: Authorizable {
        guard case ResourceTarget.type = target else {
            preconditionFailure("Resource target is not type.")
        }
        
        guard let user = user as? A else {
            preconditionFailure("Authorizable cannot be casted to \(A.self)")
        }
        
        return try closure(P.self, user, container)
    }
    
}
