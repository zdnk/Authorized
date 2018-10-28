import Foundation

struct Permission {
    
    let action: String
    let isInstance: Bool
    let isDeny: Bool
    var resolver: PermissionResolving
    
    init(action: String, instance: Bool, deny: Bool, resolver: PermissionResolving) {
        self.action = action
        self.isInstance = instance
        self.isDeny = deny
        self.resolver = resolver
    }
    
    func resolve<R, A>(_: R.Type, resource: R?, user: A) -> Bool where R: Protected, A: Authorizable {
        return resolver.resolve(R.self, resource: resource, user: user)
    }
    
}
