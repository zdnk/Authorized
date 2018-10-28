import Foundation

public struct PermissionRequest {
    
    public let authorizable: String
    public let resource: String
    public let action: String
    public let isInstance: Bool
    
    public init(authorizable: String, resource: String, action: String, isInstance: Bool) {
        self.authorizable = authorizable
        self.resource = resource
        self.action = action
        self.isInstance = isInstance
    }
    
    public init<R, A>(authorizable: A.Type, resource: R.Type, action: R.Action, isInstance: Bool) where R: Resource, A: Authorizable {
        self.authorizable = A.authorizableIdentifier
        self.resource = R.resourceIdentifier
        self.action = action.actionIdentifier
        self.isInstance = isInstance
    }
    
}
