import Foundation

struct Action: Hashable {
    
    let identifier: String
    let isInstance: Bool
    var resolver: PermissionResolving
    
    init(_ id: String, instance: Bool, resolver: PermissionResolving) {
        self.identifier = id
        self.isInstance = instance
        self.resolver = resolver
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(isInstance)
    }
    
    static func == (lhs: Action, rhs: Action) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}
