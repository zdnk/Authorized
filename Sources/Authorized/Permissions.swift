import Foundation

public typealias Permissions = PermissionGranting & PermissionDenying & PermissionVerifying

public protocol PermissionGranting {
    
    func allow(with: PermissionRequest, resolver: PermissionResolving)
    
}

public protocol PermissionDenying {
    
    func deny(with: PermissionRequest, resolver: PermissionResolving)
    
}

public protocol PermissionVerifying {
    
    func allowed<R, A>(_: R, _: R.Action, as: A) -> Bool where R: Resource, A: Authorizable
    
    func allowed<R, A>(_: R.Type, _: R.Action, as: A) -> Bool where R: Resource, A: Authorizable
    
}
