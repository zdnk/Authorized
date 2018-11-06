import Foundation

public protocol ResourcePolicy: Policy where Model: Resource, Model.Action: Hashable {
    
    associatedtype Model
    
    func mapping() throws -> ResourcePolicyMapping<Model>
    
}

extension ResourcePolicy {
    
    public func configure(in config: PermissionDefining) throws {
        let definition = try self.mapping()
        definition.add(to: config)
    }
    
}
