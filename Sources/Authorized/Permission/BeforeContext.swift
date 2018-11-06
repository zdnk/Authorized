import Vapor

public struct BeforeContext {
    
    public let target: Any
    public let action: Any
    public let user: Authorizable
    public let container: Container
    
}
