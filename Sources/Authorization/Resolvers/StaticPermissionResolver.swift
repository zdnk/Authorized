import Foundation

struct StaticPermissionResolver: PermissionResolving {
    
    let value: Bool
    
    func resolve(resource: Any, user: Any) -> Bool {
        return value
    }
    
}
