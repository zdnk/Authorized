import Foundation

public protocol ResourceAction {
    
    var actionIdentifier: String { get }
    
}

extension ResourceAction where Self: RawRepresentable, Self.RawValue == String {
    
    public var actionIdentifier: String {
        return rawValue
    }
    
}
