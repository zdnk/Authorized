import Vapor

public protocol HasRoles {
    
    associatedtype Role
    
    func has(role: Role) -> Bool
    
}
