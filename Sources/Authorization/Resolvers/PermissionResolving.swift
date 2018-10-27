import Foundation

protocol PermissionResolving {
    
    func resolve(resource: Any, user: Any) -> Bool
    
}
