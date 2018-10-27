import Foundation

public protocol Protected {
    
    associatedtype Action: ProtectedAction
    
    static var resourceIdentifier: String { get }
    
}

extension Protected {
    
    public static var resourceIdentifier: String {
        return String(describing: Self.self)
    }
    
}
