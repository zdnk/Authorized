import Foundation

struct Resource {
    
    let identifier: String
    private var storage: [Permission] = []
    
    init(_ id: String) {
        self.identifier = id
    }
    
    func permissions(for request: PermissionRequest) -> [Permission] {
        return storage.filter {
            if request.instance == false && $0.isInstance == true {
                return false
            }
            
            return $0.action == request.actionIdentifier
        }
    }
    
    mutating func addOrReplace(with permission: Permission) {
        let index = storage.firstIndex {
            return (
                $0.action == permission.action
                && $0.isInstance == permission.isInstance
                && $0.isDeny == permission.isDeny
            )
        }
        
        if let index = index {
            storage[index] = permission
        } else {
            storage.append(permission)
        }
    }
    
}
