import Foundation

public protocol Permissions {
    
    func allowed<R, A>(_: R, _: R.Action, as: A) -> Bool where R: Resource, A: Authorizable
    
    func allowed<R, A>(_: R.Type, _: R.Action, as: A) -> Bool where R: Resource, A: Authorizable
    
    func allow(with: PermissionRequest, resolver: PermissionResolving)
    
    func deny(with: PermissionRequest, resolver: PermissionResolving)
    
}
