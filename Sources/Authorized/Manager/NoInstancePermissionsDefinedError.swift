import Foundation

public struct NoInstancePermissionsDefinedError: Error {
    
    public let resource: String
    public let action: String
    public let authorizable: String
    
    public init<R, A>(resource: R.Type, action: R.Action, authorizable: A.Type) where R: Resource, A: Authorizable {
        self.resource = R.resourceIdentifier
        self.action = action.actionIdentifier
        self.authorizable = A.authorizableIdentifier
    }
    
}
