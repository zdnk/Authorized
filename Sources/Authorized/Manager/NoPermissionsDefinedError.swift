import Foundation

public struct NoPermissionsDefinedError: Error {
    
    public let resource: String
    public let action: String
    public let authorizable: String
    public let instance: Bool
    
    public init<R, A>(resource: R.Type, action: R.Action, authorizable: A.Type, instance: Bool) where R: Resource, A: Authorizable {
        self.resource = R.resourceIdentifier
        self.action = action.actionIdentifier
        self.authorizable = A.authorizableIdentifier
        self.instance = instance
    }
    
}
