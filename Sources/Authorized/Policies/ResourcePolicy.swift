import Foundation

public protocol ResourcePolicy: Policy where Model: Resource, Model.Action: Hashable {
    
    associatedtype Model
    
    func rules() -> ResourceRules<Model>
    
}

extension ResourcePolicy {
    
    public func configure(in config: PermissionDefining) throws {
        let definition = self.rules()
        definition.add(to: config)
    }
    
}
