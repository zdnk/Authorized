import Foundation

public struct Permission {
    
    public let authorizable: String
    public let resource: String
    public let action: String
    public let isInstance: Bool
    public let isDeny: Bool
    internal var resolver: PermissionResolving
    
    init(authorizable: String, resource: String, action: String, instance: Bool, deny: Bool, resolver: PermissionResolving) {
        self.authorizable = authorizable
        self.resource = resource
        self.action = action
        self.isInstance = instance
        self.isDeny = deny
        self.resolver = resolver
    }
    
    func resolve<R, A>(_: R.Type, resource: R?, user: A) -> Bool where R: Resource, A: Authorizable {
        precondition(R.resourceIdentifier == self.resource)
        precondition(A.authorizableIdentifier == self.authorizable)
        
        return resolver.resolve(R.self, resource: resource, user: user)
    }
    
}
