import Foundation

public typealias Permissions = PermissionGranting & PermissionDenying & PermissionVerifying

public protocol PermissionGranting {
    
    func allow(with: PermissionRequest, resolver: PermissionResolving)
    
}

public protocol PermissionDenying {
    
    func deny(with: PermissionRequest, resolver: PermissionResolving)
    
}

public protocol PermissionVerifying {
    
    func allowed<R, A>(_: ResourceTarget<R>, _: R.Action, as: A) -> Bool where R: Resource, A: Authorizable
    
}

extension PermissionVerifying {
    
    public func allowed<R, A>(_ resource: R, _ action: R.Action, as user: A) -> Bool where R: Resource, A: Authorizable {
        return allowed(
            .instance(resource),
            action, as:
            user
        )
    }
    
    public func allowed<R, A>(_: R.Type, _ action: R.Action, as user: A) -> Bool where R: Resource, A: Authorizable {
        return allowed(
            ResourceTarget<R>.type,
            action, as:
            user
        )
    }
    
}
