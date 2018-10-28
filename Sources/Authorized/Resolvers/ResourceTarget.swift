import Foundation

public enum ResourceTarget<R> where R: Resource {
    
    case type
    case instance(R)
    
}
