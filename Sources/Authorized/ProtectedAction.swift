import Foundation

public protocol ProtectedAction {
    
    var actionIdentifier: String { get }
    
}

extension ProtectedAction where Self: RawRepresentable, Self.RawValue == String {
    
    public var actionIdentifier: String {
        return rawValue
    }
    
}
