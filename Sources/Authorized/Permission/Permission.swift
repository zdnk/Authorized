import Foundation
import Vapor

public struct Permission {
    
    public let authorizable: String
    public let resource: String
    public let action: String
    public let isInstance: Bool
    internal var resolver: PermissionResolving
    
    init(authorizable: String, resource: String, action: String, instance: Bool, resolver: PermissionResolving) {
        self.authorizable = authorizable
        self.resource = resource
        self.action = action
        self.isInstance = instance
        self.resolver = resolver
    }
    
    func resolve<R, A>(target: ResourceTarget<R>, user: A, on container: Container) -> Future<PermissionResolution> where R: Resource, A: Authorizable {
        precondition(R.resourceIdentifier == self.resource)
        precondition(A.authorizableIdentifier == self.authorizable)
        
        do {
            return try resolver.resolve(target: target, user: user, on: container)
        } catch {
            #warning("TODO: logging?")
            print(error)
            return container.future(.deny)
        }
    }
    
}
