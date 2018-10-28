import Vapor

struct PermissionRequest {
    
    let authorizableIdentifier: String
    let resourceIdentifier: String
    let actionIdentifier: String
    let instance: Bool
    
}
