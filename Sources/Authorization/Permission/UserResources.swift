import Foundation

struct UserResources {
    
    let identifier: String
    var resources: [String: Resource] = [:]
    
    init(_ id: String) {
        self.identifier = id
    }
    
    func permission(action: String, resource: String, instance: Bool) -> Action? {
        guard let resource = resources[resource] else {
            return nil
        }
        
        return resource.action(for: action, instance: instance)
    }
    
}
