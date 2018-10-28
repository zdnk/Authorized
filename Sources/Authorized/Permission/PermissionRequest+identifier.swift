import Foundation

extension PermissionRequest {
    
    internal var identifier: String {
        return [
            self.authorizable,
            self.resource,
            self.action
        ].joined(separator: ".")
    }
    
    internal var instanceIdentifier: String {
        return "#\(identifier)"
    }
    
}
