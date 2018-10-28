import Foundation

public enum ResourceTarget<R> where R: Resource {
    
    case type
    case instance(R)
    
    public var isInstance: Bool {
        switch self {
        case .type:
            return false
        case .instance(_):
            return true
        }
    }
    
}
