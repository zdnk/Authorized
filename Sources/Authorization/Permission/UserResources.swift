import Foundation

struct UserResources {
    
    let identifier: String
    var resources: [String: Resource] = [:]
    
    init(_ id: String) {
        self.identifier = id
    }
    
    func permissions(for request: PermissionRequest) -> [Permission] {
        guard let resource = resources[request.resourceIdentifier] else {
            return []
        }
        
        return resource.permissions(for: request)
    }
    
}
