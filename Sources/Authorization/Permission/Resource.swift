import Foundation

struct Resource {
    
    let identifier: String
    var actions: Set<Action> = Set()
    
    init(_ id: String) {
        self.identifier = id
    }
    
    func action(for action: String, instance: Bool) -> Action? {
        return actions.first {
            return $0.identifier == action && $0.isInstance == instance
        }
    }
    
}
