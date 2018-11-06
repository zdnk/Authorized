import Foundation

public protocol Policy {
    
    func configure(in: PermissionDefining) throws
    
}
