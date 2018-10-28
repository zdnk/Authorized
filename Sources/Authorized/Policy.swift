import Foundation

public protocol Policy {
    
    func configure(in: PermissionGranting & PermissionDenying)
    
}
