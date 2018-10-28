import Vapor

public struct PermissionRequest {
    
    public let authorizableIdentifier: String
    public let resourceIdentifier: String
    public let actionIdentifier: String
    public let isInstance: Bool
    
    public init(authorizable: String, resource: String, action: String, isInstance: Bool) {
        self.authorizableIdentifier = authorizable
        self.resourceIdentifier = resource
        self.actionIdentifier = action
        self.isInstance = isInstance
    }
    
    public init<R, A>(authorizable: A.Type, resource: R.Type, action: R.Action, isInstance: Bool) where R: Protected, A: Authorizable {
        self.authorizableIdentifier = A.authorizableIdentifier
        self.resourceIdentifier = R.resourceIdentifier
        self.actionIdentifier = action.actionIdentifier
        self.isInstance = isInstance
    }
    
}
