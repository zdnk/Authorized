import Foundation

public protocol ResourcePolicy: Policy where Model: Resource, Model.Action: Hashable {
    
    associatedtype Model
    
    func mapping() -> ResourcePolicyMapping<Model>
    
}

extension ResourcePolicy {
    
    public func configure(in config: PermissionDefining) {
        let definition = self.mapping()
        definition.add(to: config)
    }
    
}
