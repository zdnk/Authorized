import Foundation

struct UserResources {
    
    let identifier: String
    var resources: [String: Resource] = [:]
    
    init(_ id: String) {
        self.identifier = id
    }
    
    func permissions(action: String, resource: String, instance: Bool) -> [Permission] {
        guard let resource = resources[resource] else {
            return []
        }
        
        return resource.permissions(for: action, instance: instance)
    }
    
}
