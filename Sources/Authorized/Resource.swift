import Foundation
import Vapor

public protocol Resource {
    
    associatedtype Action: ResourceAction
    
    static var resourceIdentifier: String { get }
    
}

extension Resource {
    
    public static var resourceIdentifier: String {
        return String(describing: Self.self)
    }
    
}
