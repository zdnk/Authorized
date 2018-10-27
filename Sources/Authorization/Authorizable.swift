import Foundation

public protocol Authorizable {
    
    static var authorizableIdentifier: String { get }
    
}

extension Authorizable {
    
    public static var authorizableIdentifier: String {
        return String(describing: Self.self)
    }
    
}
