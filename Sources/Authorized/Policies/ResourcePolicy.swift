import Foundation

public protocol ResourcePolicy: Policy where Model: Resource, Model.Action: Hashable {
    
    associatedtype Model
    
    func definition() -> ResourcePolicyDefinition<Model>
    
}

extension ResourcePolicy {
    
    public func configure(in config: PermissionDefining) {
        let definition = self.definition()
        definition.add(to: config)
    }
    
}
