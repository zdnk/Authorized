import Foundation

struct Resource {
    
    let identifier: String
    private var storage: [Permission] = []
    
    init(_ id: String) {
        self.identifier = id
    }
    
    func permissions(for action: String, instance: Bool) -> [Permission] {
        return storage.filter {
            if instance == false && $0.isInstance == true {
                return false
            }
            
            return $0.action == action
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
