import Vapor

extension Future where T: Resource {
    
    public func authorize<A: Authorizable>(_ action: T.Action, as user: A, on container: Container) -> Future<T> {
        return flatMap { resource in
            let permissions = try container.make(PermissionVerifying.self)
            return permissions.authorize(resource, action, as: user, on: container)
        }
    }
    
}
