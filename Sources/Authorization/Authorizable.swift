import Foundation
import Authentication

public protocol Authorizable: Authenticatable {
    
    static var authorizableIdentifier: String { get }
    
}

extension Authorizable {
    
    public static var authorizableIdentifier: String {
        return String(describing: Self.self)
    }
    
}
