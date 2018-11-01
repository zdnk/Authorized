import Foundation

public enum PermissionResolution {
    
    case allow
    case deny
    
}

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
    
    func resolve<R, A>(target: ResourceTarget<R>, user: A) -> PermissionResolution where R: Resource, A: Authorizable {
        precondition(R.resourceIdentifier == self.resource)
        precondition(A.authorizableIdentifier == self.authorizable)
        
        return resolver.resolve(target: target, user: user)
    }
    
}
